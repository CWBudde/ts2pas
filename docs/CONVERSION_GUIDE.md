# Conversion Guide: TypeScript Definitions to Pascal

This guide explains how to use the ts2pas conversion automation to systematically convert TypeScript definition packages from DefinitelyTyped.

## Quick Start

### Convert Top 10 Packages

```bash
npm run convert-top10
```

This will convert the 10 most popular @types packages and generate:
- Pascal files in `conversions/top-10/`
- JSON report in `conversions/logs/conversion-report.json`
- Detailed summary in `conversions/SUMMARY.md`

### Convert a Single Package

```bash
npx tsx scripts/convert-types-package.ts @types/PACKAGE_NAME
```

Example:
```bash
npx tsx scripts/convert-types-package.ts @types/axios
```

### Convert Multiple Custom Packages

```bash
npx tsx scripts/convert-types-package.ts @types/axios @types/moment @types/d3
```

## Conversion Process

### What Happens During Conversion

1. **Fetch** - Downloads `index.d.ts` from DefinitelyTyped GitHub repository
2. **Parse** - Uses TypeScript compiler API to parse definitions
3. **Transform** - Converts TypeScript AST to Pascal AST
4. **Generate** - Produces formatted Pascal code
5. **Save** - Writes output to `conversions/top-10/PACKAGE.pas`
6. **Log** - Records statistics in conversion report

### Output Files

For each package conversion:

**Pascal File:** `conversions/top-10/PACKAGE.pas`
```pascal
unit JS_PACKAGE;

interface

(*
   * Auto-generated from TypeScript definitions
   * Source: PACKAGE
   * Generator: ts2pas v2.0.0-beta.1
   *)

// Type definitions and function declarations...

implementation

end.
```

**JSON Log Entry:** `conversions/logs/conversion-report.json`
```json
{
  "packageName": "@types/PACKAGE",
  "success": true,
  "outputFile": "conversions\\top-10\\PACKAGE.pas",
  "stats": {
    "linesOfTypeScript": 100,
    "linesOfPascal": 50,
    "conversionTime": 500
  }
}
```

## Understanding Conversion Results

### Success Indicators

✅ **Good Conversion:**
- Multiple function declarations
- Class and interface definitions
- Proper type mappings
- 50+ lines of Pascal output

Example: `@types/fs-extra` → 126 lines of Pascal

### Partial Results

⚠️ **Minimal Conversion:**
- Mostly type aliases
- Few concrete declarations
- ~19 lines (boilerplate only)

Example: `@types/node` → 19 lines (main file is re-exports)

**Why This Happens:**
- Main `index.d.ts` only re-exports submodules
- Package uses advanced TypeScript features not yet supported
- Primarily type-only exports

**Solution:**
- Convert submodules individually
- Use multi-file conversion mode (future feature)

## Advanced Usage

### Custom Output Directory

Edit `scripts/convert-types-package.ts`:

```typescript
const result = await convertTypesPackage(
  '@types/axios',
  'conversions/custom-output'  // Custom directory
);
```

### Conversion Options

Customize conversion behavior in the script:

```typescript
const pascalContent = convertTypeScriptToPascal(tsContent, {
  fileName: pkgName,
  indentSize: 2,           // or 4
  // Add more options as needed
});
```

## Analyzing Results

### View Statistics

Check the JSON report:
```bash
cat conversions/logs/conversion-report.json
```

Or use jq for formatted output:
```bash
jq '.' conversions/logs/conversion-report.json
```

### Calculate Metrics

```bash
# Count successful conversions
jq '[.[] | select(.success == true)] | length' conversions/logs/conversion-report.json

# Get average conversion time
jq '[.[] | .stats.conversionTime] | add / length' conversions/logs/conversion-report.json

# Find largest output
jq 'max_by(.stats.linesOfPascal)' conversions/logs/conversion-report.json
```

## Working with the Roadmap

### Update Status

After converting a package, update `CONVERSION_ROADMAP.md`:

1. Find the package in the appropriate section
2. Change status from ⏳ to ✅
3. Add output size: "Package name - X lines"
4. Update statistics section

Example:
```markdown
| 11 | @types/prop-types | React | High | ✅ React prop validation - 45 lines |
```

### Track Progress

Update statistics:
```markdown
## Statistics

- **Total Packages:** 100
- **Completed:** 11 ✅  (was 10)
- **Pending:** 89      (was 90)
- **Success Rate:** 100% (11/11)
```

## Troubleshooting

### Common Issues

**Problem:** Package not found (404 error)

**Solution:**
- Verify package exists: https://www.npmjs.com/package/@types/PACKAGE
- Check DefinitelyTyped repo: https://github.com/DefinitelyTyped/DefinitelyTyped/tree/master/types/PACKAGE
- Package name might be different (e.g., `@types/node` → `node` directory)

**Problem:** Empty or minimal output

**Solution:**
- This is expected for re-export packages
- Convert submodules individually
- Check `index.d.ts` content on GitHub first

**Problem:** TypeScript parsing errors

**Solution:**
- Check TypeScript version compatibility
- Some bleeding-edge syntax may not be supported yet
- Report as issue for tool improvement

### Debug Mode

Add verbose logging to the script:

```typescript
console.log('TypeScript content:', tsContent.substring(0, 500));
console.log('Pascal output:', pascalContent.substring(0, 500));
```

## Best Practices

### Before Converting

1. **Check Package Popularity:** Focus on high-download packages first
2. **Review Source:** Look at the TypeScript file structure on GitHub
3. **Identify Dependencies:** Note what other packages it depends on
4. **Set Expectations:** Complex packages may need manual post-processing

### During Conversion

1. **Monitor Output:** Watch for errors or warnings
2. **Review Generated Code:** Check a few converted files manually
3. **Note Issues:** Document any problems for tool improvement

### After Conversion

1. **Validate Pascal:** Ensure syntax is correct
2. **Test Compilation:** Try compiling in DWScript if possible
3. **Update Documentation:** Mark package as complete in roadmap
4. **Share Results:** Contribute findings back to project

## Batch Processing Strategy

### By Category

Convert related packages together:

```bash
# React ecosystem
npx tsx scripts/convert-types-package.ts \
  @types/react \
  @types/react-dom \
  @types/react-router \
  @types/react-redux

# Testing frameworks
npx tsx scripts/convert-types-package.ts \
  @types/jest \
  @types/mocha \
  @types/chai \
  @types/sinon
```

### By Priority

Follow the roadmap tiers:
1. **Tier 1:** High-value packages (15 packages)
2. **Tier 2:** Medium-value packages (35 packages)
3. **Tier 3:** Lower priority packages (40 packages)

### Automated Batching

Create a script for tier conversion:

```bash
# Convert all Tier 1 packages
cat tier1-packages.txt | xargs npx tsx scripts/convert-types-package.ts
```

## Integration with Development

### Git Workflow

```bash
# Create feature branch
git checkout -b convert-react-ecosystem

# Run conversions
npm run convert-top10

# Review changes
git status
git diff

# Commit results
git add conversions/
git commit -m "Add Pascal conversions for top 10 @types packages

- Converted 10 packages successfully
- 100% success rate
- See conversions/SUMMARY.md for details"
```

### CI/CD Integration

Add to GitHub Actions:

```yaml
- name: Run Type Conversions
  run: npm run convert-top10

- name: Verify Outputs
  run: test -f conversions/logs/conversion-report.json
```

## Contributing

### Adding New Packages to Roadmap

1. Research package popularity (npm downloads)
2. Add to appropriate category in `CONVERSION_ROADMAP.md`
3. Assign priority (High/Medium/Low)
4. Add brief description

### Improving Conversion Script

Common enhancements:
- Add error recovery
- Support multi-file packages
- Improve type mapping
- Add validation step

## Resources

- **Tool Documentation:** `README.md`
- **Conversion Roadmap:** `CONVERSION_ROADMAP.md`
- **Results Summary:** `conversions/SUMMARY.md`
- **Script Source:** `scripts/convert-types-package.ts`

## Support

For issues or questions:
1. Check this guide
2. Review `SUMMARY.md` for known issues
3. Check existing GitHub issues
4. Open new issue with:
   - Package name
   - Error message
   - Expected vs actual output

---

**Last Updated:** 2025-10-26
**Tool Version:** ts2pas v2.0.0-beta.1
