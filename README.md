# ts2pas v2

> TypeScript definition file to DWScript Pascal converter - Modern TypeScript implementation

[![CI](https://github.com/CWBudde/ts2pas/actions/workflows/ci.yml/badge.svg)](https://github.com/CWBudde/ts2pas/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.6-blue)](https://www.typescriptlang.org/)
[![Node.js](https://img.shields.io/badge/Node.js-18+-green)](https://nodejs.org/)
[![npm version](https://img.shields.io/npm/v/@cwbudde/ts2pas.svg)](https://www.npmjs.com/package/@cwbudde/ts2pas)
[![codecov](https://codecov.io/gh/CWBudde/ts2pas/branch/master/graph/badge.svg)](https://codecov.io/gh/CWBudde/ts2pas)

A modern tool to convert TypeScript definition files (`.d.ts`) to DWScript-based Object Pascal headers. This is a complete rewrite of the original ts2pas in TypeScript with comprehensive test coverage and modern tooling.

## What's New in v2

- **Complete TypeScript Rewrite**: Built with TypeScript 5.6+ for better maintainability
- **Modern Architecture**: Proper AST transformation pipeline with visitor pattern
- **Comprehensive Testing**: 169 tests with 89.91% coverage (100% on core AST)
- **Better Type Support**: Improved handling of generics, unions, and complex types
- **Enum Support**: Proper Pascal enum syntax with smart formatting
- **Enhanced CLI**: Watch mode, batch processing, GitHub URL fetching, config files
- **TypeScript Compiler API**: Uses official TypeScript parser for accuracy
- **Regression Testing**: Automated baseline comparison for stability
- **CI/CD**: Automated testing on multiple platforms and Node.js versions

## Installation

```bash
npm install -g @cwbudde/ts2pas
```

Or use with npx:

```bash
npx @cwbudde/ts2pas input.d.ts output.pas
```

## Usage

### CLI

```bash
# Basic usage
ts2pas input.d.ts [output.pas] [options]

# Commands
ts2pas watch <input...>       # Watch files for changes
ts2pas batch <pattern>        # Batch process multiple files

Options:
  --url <url>              Fetch TypeScript definitions from GitHub URL
  --config <path>          Path to configuration file
  --indent <size>          Indentation size (default: 2)
  --style <style>          Output style: dws|pas2js (default: dws)
  --verbose                Enable verbose output
  -h, --help              Display help information
  -V, --version           Display version information
```

### Examples

#### Basic Conversion

```bash
# Convert a single file
ts2pas react.d.ts react.pas

# Custom indentation and style
ts2pas axios.d.ts --indent 4 --style pas2js

# Verbose mode for debugging
ts2pas express.d.ts --verbose
```

#### Download from GitHub

```bash
# Fetch TypeScript definitions from GitHub
ts2pas --url https://github.com/DefinitelyTyped/DefinitelyTyped/blob/master/types/lodash/index.d.ts

# With custom output path
ts2pas --url https://github.com/.../react.d.ts react.pas
```

#### Configuration File

```bash
# Create a config file: ts2pas.config.json
{
  "indentSize": 4,
  "style": "pas2js",
  "verbose": true
}

# Use config file
ts2pas input.d.ts --config ts2pas.config.json

# CLI options override config file
ts2pas input.d.ts --config ts2pas.config.json --indent 2
```

#### Watch Mode

```bash
# Watch a single file
ts2pas watch src/types.d.ts -o output/

# Watch multiple files with glob pattern
ts2pas watch "src/**/*.d.ts" -o dist/

# Watch with config
ts2pas watch "types/*.d.ts" --config ts2pas.config.json -o output/
```

#### Batch Processing

```bash
# Process all .d.ts files in directory
ts2pas batch "types/*.d.ts" -o output/

# Process with pattern
ts2pas batch "src/**/*.d.ts" --indent 4 -o dist/

# Batch with config
ts2pas batch "**/*.d.ts" --config ts2pas.config.json -o output/
```

### Programmatic API

```typescript
import { parseTypeScriptDefinition, transformSourceFile, PascalCodeGenerator } from '@cwbudde/ts2pas';

// Parse TypeScript
const parseResult = parseTypeScriptDefinition(tsCode);

// Transform to Pascal AST
const pascalUnit = transformSourceFile(parseResult.sourceFile, {
  unitName: 'MyUnit',
  namespacePrefix: 'My'
});

// Generate Pascal code
const generator = new PascalCodeGenerator({ indentSize: 2 });
const pascalCode = generator.generateUnit(pascalUnit);
```

## Features

### TypeScript Support

- ✅ Classes (with inheritance, constructors, methods, properties)
- ✅ Interfaces (with extends, optional properties)
- ✅ Type aliases
- ✅ Enums (numeric, string, const)
- ✅ Functions and methods
- ✅ Generics
- ✅ Union types
- ✅ Arrays and tuples
- ✅ Optional and default parameters
- ✅ Visibility modifiers (public, private, protected)
- ✅ Static members
- ✅ Readonly properties

### Pascal Output

- External class declarations for DWScript
- Proper enum syntax with smart formatting
- Method overloading support
- Type mapping (TypeScript → Pascal)
- Configurable indentation
- Clean, readable code generation

### CLI Features

- ✅ Basic file conversion with progress indicators
- ✅ Watch mode for automatic regeneration
- ✅ Batch processing with glob patterns
- ✅ GitHub URL fetching (auto-converts to raw URLs)
- ✅ Configuration file support (JSON)
- ✅ Colored output and spinners
- ✅ Verbose mode for debugging
- ✅ Error handling with user-friendly messages

## Architecture

```
src/
├── parser/       # TypeScript AST parsing
├── ast/          # AST transformation
├── codegen/      # Pascal code generation
├── types.ts      # Pascal AST definitions
└── index.ts      # Main API
```

## Development

```bash
# Install dependencies
npm install

# Run tests
npm test

# Run tests with coverage
npm run test:coverage

# Build
npm run build

# Lint
npm run lint

# Format
npm run format
```

## Testing

The project has comprehensive test coverage:

- **169 tests** across 8 test suites
- **89.91% overall coverage** (exceeds 80% target)
- **100% coverage** on core AST transformation
- **97% coverage** on main converter
- Tests for all major TypeScript features
- Integration tests with real-world examples
- Regression tests with baseline comparison
- Real-world TypeScript library tests

## Legacy Version

The original Node.js and Pascal implementations are preserved in the `legacy/` directory:
- `legacy/v1-nodejs/` - Original Node.js implementation (v0.5.0)
- `legacy/v1-pascal/` - Original DWScript/Pascal implementation

## Compatibility

- **Node.js**: 18.0.0 or higher
- **TypeScript**: 5.6 or higher
- **Output**: DWScript (Smart Mobile Studio, DWS Web Server)

## Tested Definitions

The tool has been tested with TypeScript definitions from [Definitely Typed](https://definitelytyped.org/), including:

- React, Angular, Vue
- jQuery, Lodash, D3
- Node.js, Express
- Three.js, Babylon.js
- And many more...

## Known Limitations

- Some complex generic constraints may need manual adjustment
- Function overloads are translated but may require ordering
- Advanced TypeScript features (mapped types, conditional types) have limited support
- Output may require manual post-processing for class forward declarations

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT © Christian-W. Budde

## Release History

### v2.0.0-beta.1 (2025)
- Complete rewrite in TypeScript
- Modern architecture with AST transformation
- Comprehensive test coverage (169 tests, 89.91% coverage)
- Better type support and enum handling
- Enhanced CLI with watch mode, batch processing, and GitHub URL support
- Configuration file support
- CI/CD with multi-platform testing
- Regression testing framework

### v0.5.0 (Legacy)
- Several notable improvements (in the parser and generator)
- See `legacy/` directory for older versions

## Links

- [Repository](https://github.com/CWBudde/ts2pas)
- [Issues](https://github.com/CWBudde/ts2pas/issues)
- [DWScript](https://www.delphitools.info/dwscript/)
- [Definitely Typed](https://definitelytyped.org/)
