# ts2pas v2

> TypeScript definition file to DWScript Pascal converter - Modern TypeScript implementation

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.6-blue)](https://www.typescriptlang.org/)
[![Node.js](https://img.shields.io/badge/Node.js-18+-green)](https://nodejs.org/)

A modern tool to convert TypeScript definition files (`.d.ts`) to DWScript-based Object Pascal headers. This is a complete rewrite of the original ts2pas in TypeScript with comprehensive test coverage and modern tooling.

## What's New in v2

- **Complete TypeScript Rewrite**: Built with TypeScript 5.6+ for better maintainability
- **Modern Architecture**: Proper AST transformation pipeline with visitor pattern
- **Comprehensive Testing**: 137 tests with high coverage (100% on core AST)
- **Better Type Support**: Improved handling of generics, unions, and complex types
- **Enum Support**: Proper Pascal enum syntax with smart formatting
- **CLI Improvements**: Better error messages and progress indicators
- **TypeScript Compiler API**: Uses official TypeScript parser for accuracy

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
ts2pas input.d.ts [output.pas] [options]

Options:
  -o, --output <file>      Output file path
  -p, --prefix <prefix>    Namespace prefix for unit names
  -i, --indent <size>      Indentation size (default: 2)
  -s, --style <style>      Output style: dws|pas2js (default: dws)
  -v, --verbose            Enable verbose output
  -h, --help              Display help information
  --version               Display version information
```

### Examples

```bash
# Basic conversion
ts2pas react.d.ts react.pas

# With namespace prefix
ts2pas lodash.d.ts --prefix Lodash

# Custom indentation
ts2pas axios.d.ts --indent 4

# Verbose mode
ts2pas express.d.ts --verbose
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

- **137 tests** across 6 test suites
- **100% coverage** on core AST transformation
- **97% coverage** on main converter
- Tests for all major TypeScript features
- Integration tests with real-world examples

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
- Comprehensive test coverage
- Better type support and enum handling

### v0.5.0 (Legacy)
- Several notable improvements (in the parser and generator)
- See `legacy/` directory for older versions

## Links

- [Repository](https://github.com/CWBudde/ts2pas)
- [Issues](https://github.com/CWBudde/ts2pas/issues)
- [DWScript](https://www.delphitools.info/dwscript/)
- [Definitely Typed](https://definitelytyped.org/)
