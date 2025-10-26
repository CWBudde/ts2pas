#!/usr/bin/env tsx

import { writeFile, mkdir, readFile } from 'fs/promises';
import { existsSync } from 'fs';
import { join, dirname } from 'path';
import https from 'https';
import {
  convertTypeScriptToPascal,
  convertTypeScriptToPascalWithMetadata,
} from '../src/index.js';
import {
  parseReferenceDirectives,
  normalizeReferencePath,
  referenceToUnitName,
  getPackageNameFromTypesRef,
} from '../src/utils/references.js';

interface ConversionResult {
  packageName: string;
  success: boolean;
  outputFile?: string;
  error?: string;
  warnings?: string[];
  stats?: {
    linesOfTypeScript: number;
    linesOfPascal: number;
    conversionTime: number;
  };
}

/**
 * Fetch content from URL
 */
async function fetchFromUrl(url: string): Promise<string> {
  return new Promise((resolve, reject) => {
    https.get(url, (res): void => {
      if (res.statusCode === 301 || res.statusCode === 302) {
        const location = res.headers.location;
        if (location) {
          fetchFromUrl(location).then(resolve).catch(reject);
          return;
        }
        reject(new Error('Redirect missing location header'));
        return;
      }

      if (res.statusCode !== 200) {
        reject(new Error(`HTTP ${res.statusCode}: ${res.statusMessage}`));
        return;
      }

      let data = '';
      res.on('data', (chunk) => (data += chunk));
      res.on('end', () => resolve(data));
    }).on('error', reject);
  });
}

/**
 * Get the main index.d.ts URL for a @types package
 */
function getTypesPackageUrl(packageName: string): string {
  // Remove @types/ prefix if present
  const pkgName = packageName.replace('@types/', '');
  return `https://raw.githubusercontent.com/DefinitelyTyped/DefinitelyTyped/master/types/${pkgName}/index.d.ts`;
}

/**
 * Get the URL for a specific file in a @types package
 */
function getTypesFileUrl(packageName: string, filePath: string): string {
  const pkgName = packageName.replace('@types/', '');
  const normalizedPath = normalizeReferencePath(filePath);
  return `https://raw.githubusercontent.com/DefinitelyTyped/DefinitelyTyped/master/types/${pkgName}/${normalizedPath}`;
}

/**
 * Represents a TypeScript file in a package with its dependencies
 */
interface TypeScriptFile {
  /** Package name (e.g., "jquery") */
  packageName: string;
  /** File path relative to package root (e.g., "JQuery.d.ts" or "index.d.ts") */
  filePath: string;
  /** File content */
  content: string;
  /** Files this file references */
  references: ReferenceInfo[];
  /** Generated Pascal unit name */
  unitName: string;
}

/**
 * Reference information
 */
interface ReferenceInfo {
  /** Type of reference */
  type: 'path' | 'types';
  /** Referenced package name (for types refs) or file path (for path refs) */
  target: string;
  /** Generated unit name that this references */
  unitName: string;
}

/**
 * Result of multi-file conversion
 */
interface MultiFileConversionResult {
  success: boolean;
  files: TypeScriptFile[];
  error?: string;
  totalFiles: number;
  conversionTime: number;
}

/**
 * Fetch all files for a multi-file package recursively
 */
async function fetchPackageFilesRecursively(
  packageName: string,
  visited: Set<string> = new Set(),
  namespacePrefix: string = 'JS'
): Promise<TypeScriptFile[]> {
  const pkgName = packageName.replace('@types/', '');
  const files: TypeScriptFile[] = [];

  // Start with index.d.ts
  const indexKey = `${pkgName}:index.d.ts`;
  if (visited.has(indexKey)) {
    return files;
  }

  console.log(`  📄 Fetching ${pkgName}/index.d.ts...`);

  try {
    const indexUrl = getTypesPackageUrl(packageName);
    const indexContent = await fetchFromUrl(indexUrl);

    // Parse references from index.d.ts
    const refs = parseReferenceDirectives(indexContent);

    const indexFile: TypeScriptFile = {
      packageName: pkgName,
      filePath: 'index.d.ts',
      content: indexContent,
      references: [],
      unitName: referenceToUnitName(pkgName, namespacePrefix),
    };

    visited.add(indexKey);
    files.push(indexFile);

    // Process each reference
    for (const ref of refs) {
      if (ref.type === 'path') {
        // Local file reference
        const fileKey = `${pkgName}:${ref.value}`;
        if (visited.has(fileKey)) {
          continue;
        }

        console.log(`    📄 Fetching ${pkgName}/${ref.value}...`);

        try {
          const fileUrl = getTypesFileUrl(packageName, ref.value);
          const fileContent = await fetchFromUrl(fileUrl);

          // Recursively parse this file's references
          const fileRefs = parseReferenceDirectives(fileContent);

          const unitName = referenceToUnitName(
            `${pkgName}_${ref.value.replace(/\.d\.ts$/, '')}`,
            namespacePrefix
          );

          const tsFile: TypeScriptFile = {
            packageName: pkgName,
            filePath: ref.value,
            content: fileContent,
            references: [],
            unitName,
          };

          visited.add(fileKey);
          files.push(tsFile);

          // Add reference from index to this file
          indexFile.references.push({
            type: 'path',
            target: ref.value,
            unitName,
          });

          // Process nested references in this file
          for (const nestedRef of fileRefs) {
            if (nestedRef.type === 'path') {
              const nestedFileKey = `${pkgName}:${nestedRef.value}`;
              if (!visited.has(nestedFileKey)) {
                // Fetch nested file
                try {
                  const nestedUrl = getTypesFileUrl(packageName, nestedRef.value);
                  const nestedContent = await fetchFromUrl(nestedUrl);

                  const nestedUnitName = referenceToUnitName(
                    `${pkgName}_${nestedRef.value.replace(/\.d\.ts$/, '')}`,
                    namespacePrefix
                  );

                  const nestedFile: TypeScriptFile = {
                    packageName: pkgName,
                    filePath: nestedRef.value,
                    content: nestedContent,
                    references: [],
                    unitName: nestedUnitName,
                  };

                  visited.add(nestedFileKey);
                  files.push(nestedFile);

                  // Add reference
                  tsFile.references.push({
                    type: 'path',
                    target: nestedRef.value,
                    unitName: nestedUnitName,
                  });
                } catch (err) {
                  console.warn(`    ⚠️  Could not fetch ${nestedRef.value}: ${err}`);
                }
              } else {
                // Already visited, just add reference
                const existingFile = files.find((f) => f.filePath === nestedRef.value);
                if (existingFile) {
                  tsFile.references.push({
                    type: 'path',
                    target: nestedRef.value,
                    unitName: existingFile.unitName,
                  });
                }
              }
            } else if (nestedRef.type === 'types') {
              // External package reference
              const extPkgName = getPackageNameFromTypesRef(nestedRef.value);
              const extUnitName = referenceToUnitName(extPkgName, namespacePrefix);

              tsFile.references.push({
                type: 'types',
                target: extPkgName,
                unitName: extUnitName,
              });

              // Recursively fetch external package (with depth limit)
              if (visited.size < 100) {
                // Limit to prevent infinite recursion
                const extFiles = await fetchPackageFilesRecursively(
                  `@types/${extPkgName}`,
                  visited,
                  namespacePrefix
                );
                files.push(...extFiles);
              }
            }
          }
        } catch (err) {
          console.warn(`    ⚠️  Could not fetch ${ref.value}: ${err}`);
        }
      } else if (ref.type === 'types') {
        // External package reference
        const extPkgName = getPackageNameFromTypesRef(ref.value);
        const extUnitName = referenceToUnitName(extPkgName, namespacePrefix);

        indexFile.references.push({
          type: 'types',
          target: extPkgName,
          unitName: extUnitName,
        });

        // Recursively fetch external package (with depth limit)
        if (visited.size < 100) {
          // Limit to prevent infinite recursion
          const extFiles = await fetchPackageFilesRecursively(
            `@types/${extPkgName}`,
            visited,
            namespacePrefix
          );
          files.push(...extFiles);
        }
      }
    }
  } catch (error) {
    console.error(`  ❌ Failed to fetch ${packageName}: ${error}`);
    throw error;
  }

  return files;
}

/**
 * Convert a multi-file @types package to Pascal
 */
async function convertMultiFilePackage(
  packageName: string,
  outputDir: string = 'conversions',
  namespacePrefix: string = 'JS'
): Promise<MultiFileConversionResult> {
  const startTime = Date.now();

  try {
    console.log(`\n📦 Fetching multi-file package ${packageName}...`);

    // Fetch all files recursively
    const files = await fetchPackageFilesRecursively(packageName, new Set(), namespacePrefix);

    console.log(`✓ Downloaded ${files.length} files`);

    // Ensure output directory exists
    if (!existsSync(outputDir)) {
      await mkdir(outputDir, { recursive: true });
    }

    // Convert each file to Pascal
    console.log(`🔄 Converting ${files.length} files to Pascal...`);

    for (const file of files) {
      // Build uses clause from references
      const usesClause = file.references.map((ref) => ref.unitName);

      // Convert to Pascal
      const pascalContent = convertTypeScriptToPascal(file.content, {
        fileName: file.filePath.replace(/\.d\.ts$/, ''),
        indentSize: 2,
        namespacePrefix,
        usesClause,
        unitName: file.unitName,  // Use the pre-computed unit name
      });

      // Write output file
      const outputFile = join(outputDir, `${file.unitName}.pas`);
      await writeFile(outputFile, pascalContent, 'utf-8');

      console.log(`  ✓ ${file.unitName}.pas`);
    }

    const conversionTime = Date.now() - startTime;

    console.log(
      `\n✅ Successfully converted ${files.length} files in ${conversionTime}ms`
    );

    return {
      success: true,
      files,
      totalFiles: files.length,
      conversionTime,
    };
  } catch (error) {
    const conversionTime = Date.now() - startTime;
    return {
      success: false,
      files: [],
      error: error instanceof Error ? error.message : String(error),
      totalFiles: 0,
      conversionTime,
    };
  }
}

/**
 * Convert a @types package to Pascal (single-file version)
 */
async function convertTypesPackage(
  packageName: string,
  outputDir: string = 'conversions',
  autoDetectManifest: boolean = true
): Promise<ConversionResult> {
  const result: ConversionResult = {
    packageName,
    success: false,
  };

  const startTime = Date.now();

  try {
    console.log(`\n📦 Fetching ${packageName}...`);

    // Fetch TypeScript definition
    const url = getTypesPackageUrl(packageName);
    const tsContent = await fetchFromUrl(url);

    console.log(`✓ Downloaded ${tsContent.length} bytes`);

    // Count TypeScript lines
    const tsLines = tsContent.split('\n').length;

    // Convert to Pascal with metadata
    console.log(`🔄 Converting to Pascal...`);
    const pkgName = packageName.replace('@types/', '');
    const conversionResult = convertTypeScriptToPascalWithMetadata(tsContent, {
      fileName: pkgName,
      indentSize: 2,
      namespacePrefix: '',  // Use clean unit names without prefix
    });

    // Check if this is a re-export manifest
    if (autoDetectManifest && conversionResult.analysis.isReExportManifest) {
      console.log(
        `\n⚠️  Re-export manifest detected (confidence: ${conversionResult.analysis.manifestConfidence}%)`
      );
      console.log(
        `   Found ${conversionResult.references.length} reference(s), switching to multi-file mode...`
      );

      // Recursively convert with multi-file support
      return await convertMultiFilePackage(packageName, outputDir);
    }

    const pascalContent = conversionResult.pascalCode;

    // Count Pascal lines
    const pasLines = pascalContent.split('\n').length;

    // Ensure package subdirectory exists
    const packageDir = join(outputDir, pkgName);
    if (!existsSync(packageDir)) {
      await mkdir(packageDir, { recursive: true });
    }

    // Write output file to package subdirectory
    const outputFile = join(packageDir, `${pkgName}.pas`);
    await writeFile(outputFile, pascalContent, 'utf-8');

    const conversionTime = Date.now() - startTime;

    // Add warning if manifest was detected but not auto-converted
    const warnings: string[] = [];
    if (
      !autoDetectManifest &&
      conversionResult.analysis.isReExportManifest &&
      conversionResult.references.length > 0
    ) {
      warnings.push(
        `Re-export manifest with ${conversionResult.references.length} references - consider multi-file conversion`
      );
    }

    result.success = true;
    result.outputFile = outputFile;
    result.warnings = warnings.length > 0 ? warnings : undefined;
    result.stats = {
      linesOfTypeScript: tsLines,
      linesOfPascal: pasLines,
      conversionTime,
    };

    console.log(`✅ Successfully converted to ${outputFile}`);
    console.log(
      `   Stats: ${tsLines} TS lines → ${pasLines} Pascal lines (${conversionTime}ms)`
    );

    if (warnings.length > 0) {
      warnings.forEach((warning) => console.warn(`   ⚠️  ${warning}`));
    }
  } catch (error) {
    result.error = error instanceof Error ? error.message : String(error);
    console.error(`❌ Failed to convert ${packageName}: ${result.error}`);
  }

  return result;
}

/**
 * Convert multiple packages and generate a report
 */
async function convertMultiplePackages(
  packages: string[],
  outputDir: string = 'conversions'
): Promise<void> {
  console.log(`\n🚀 Starting batch conversion of ${packages.length} packages...\n`);

  const results: ConversionResult[] = [];

  for (const pkg of packages) {
    const result = await convertTypesPackage(pkg, outputDir);
    results.push(result);
  }

  // Generate report
  const reportPath = join('conversions/logs', 'conversion-report.json');
  await mkdir('conversions/logs', { recursive: true });
  await writeFile(reportPath, JSON.stringify(results, null, 2), 'utf-8');

  // Print summary
  console.log(`\n\n📊 Conversion Summary`);
  console.log(`${'='.repeat(60)}`);
  const successful = results.filter((r) => r.success).length;
  const failed = results.filter((r) => !r.success).length;
  console.log(`✅ Successful: ${successful}/${packages.length}`);
  console.log(`❌ Failed: ${failed}/${packages.length}`);

  if (failed > 0) {
    console.log(`\n❌ Failed packages:`);
    results
      .filter((r) => !r.success)
      .forEach((r) => console.log(`   - ${r.packageName}: ${r.error}`));
  }

  console.log(`\n📝 Full report saved to: ${reportPath}`);
}

// Main execution
const TOP_10_PACKAGES = [
  '@types/node',
  '@types/react',
  '@types/lodash',
  '@types/express',
  '@types/react-dom',
  '@types/jest',
  '@types/jquery',
  '@types/fs-extra',
  '@types/yargs',
  '@types/cordova',
];

// Run if called directly
if (import.meta.url === `file://${process.argv[1].replace(/\\/g, '/')}`) {
  const args = process.argv.slice(2);

  // Check for --multi-file flag
  const multiFileMode = args.includes('--multi-file');
  const packages = args.filter((arg) => !arg.startsWith('--'));

  if (multiFileMode) {
    // Multi-file conversion mode
    if (packages.length === 0) {
      console.error('Please specify at least one package for multi-file conversion');
      console.log('Usage: npx tsx scripts/convert-types-package.ts --multi-file @types/jquery');
      process.exit(1);
    }

    // Convert each package with multi-file support
    (async () => {
      for (const pkg of packages) {
        const result = await convertMultiFilePackage(pkg);
        if (!result.success) {
          console.error(`Failed to convert ${pkg}: ${result.error}`);
        }
      }
    })().catch(console.error);
  } else {
    // Single-file conversion mode (original behavior)
    if (packages.length === 0) {
      // Convert all top 10
      convertMultiplePackages(TOP_10_PACKAGES).catch(console.error);
    } else {
      // Convert specific packages
      convertMultiplePackages(packages).catch(console.error);
    }
  }
}

export { convertTypesPackage, convertMultiplePackages, convertMultiFilePackage };
