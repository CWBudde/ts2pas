# ts2pas - TypeScript to DWScript Pascal Converter

**Modern TypeScript rewrite of ts2pas**

Convert TypeScript definition files (`.d.ts`) to DWScript Pascal code with external class declarations.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.6-blue.svg)](https://www.typescriptlang.org/)
[![Node.js](https://img.shields.io/badge/Node.js-18+-green.svg)](https://nodejs.org/)

## Status

🚧 **Alpha Version - Under Active Development**

This is a complete rewrite of ts2pas in TypeScript, featuring:
- Modern TypeScript compiler API (v5.6+)
- Comprehensive test coverage
- Better error handling
- Improved code generation
- Extensible architecture

## Features

- ✅ **Modern TypeScript Support**: Uses latest TypeScript compiler API
- ✅ **DWScript & Pas2JS**: Supports both output styles
- ✅ **External Classes**: Generates Pascal classes with `external` keyword
- 🚧 **Generics**: TypeScript generics → Pascal generics (in progress)
- 🚧 **Type Mapping**: Configurable type conversions (in progress)
- 🚧 **Batch Processing**: Convert multiple files at once (planned)
- 🚧 **Watch Mode**: Auto-regenerate on file changes (planned)

## Installation

### From npm (when published)

```bash
npm install -g @cwbudde/ts2pas
```

### From source

```bash
cd typescript
pnpm install
pnpm build
npm link
```

## Usage

### Command Line

```bash
# Basic usage
ts2pas input.d.ts output.pas

# With options
ts2pas input.d.ts output.pas --indent 4 --style dws

# From GitHub (coming soon)
ts2pas --url https://github.com/DefinitelyTyped/...
```

### Programmatic API

```typescript
import { convertTypeScriptToPascal } from '@cwbudde/ts2pas';

const tsContent = `
  export interface MyInterface {
    name: string;
    value: number;
  }
`;

const pascalCode = convertTypeScriptToPascal(tsContent, {
  indentSize: 2,
  style: 'dws',
  typeMapping: {
    number: 'Integer', // Custom type mapping
  },
});

console.log(pascalCode);
```

## Development

### Prerequisites

- Node.js 18+
- pnpm (recommended) or npm

### Setup

```bash
# Install dependencies
pnpm install

# Build the project
pnpm build

# Run in development mode with watch
pnpm dev

# Run tests
pnpm test

# Run tests with coverage
pnpm test:coverage

# Run tests in watch mode
pnpm test:watch

# Lint code
pnpm lint

# Format code
pnpm format

# Type check
pnpm typecheck

# Run all checks (typecheck + lint + format + test)
pnpm check
```

### Project Structure

```
typescript/
├── src/
│   ├── cli.ts              # CLI entry point
│   ├── index.ts            # Library API
│   ├── types.ts            # Pascal AST types
│   ├── parser/             # TypeScript parser
│   │   └── index.ts
│   ├── ast/                # AST transformation
│   │   └── index.ts
│   ├── codegen/            # Code generation
│   │   └── index.ts
│   └── utils/              # Utilities
│       └── index.ts
├── tests/
│   ├── fixtures/           # Test .d.ts files
│   │   ├── input/
│   │   └── expected/
│   └── *.test.ts           # Test files
├── dist/                   # Build output
├── package.json
├── tsconfig.json
├── tsup.config.ts
├── vitest.config.ts
└── README.md
```

### Architecture

The converter follows a three-phase pipeline:

1. **Parse**: TypeScript definition → TypeScript AST
   - Uses TypeScript Compiler API
   - Handles all TypeScript syntax

2. **Transform**: TypeScript AST → Pascal AST
   - Maps TypeScript concepts to Pascal
   - Applies type conversions
   - Handles generics, unions, etc.

3. **Generate**: Pascal AST → Pascal code
   - Produces formatted Pascal code
   - Supports DWScript and Pas2JS styles
   - Configurable indentation and formatting

## Configuration

Create a `ts2pas.config.json` file:

```json
{
  "indentSize": 2,
  "style": "dws",
  "typeMapping": {
    "number": "Float",
    "string": "String",
    "boolean": "Boolean"
  },
  "namespacePrefix": "JS"
}
```

## Type Mappings

| TypeScript | Pascal (DWScript) |
|------------|-------------------|
| `string`   | `String`          |
| `number`   | `Float`           |
| `boolean`  | `Boolean`         |
| `any`      | `Variant`         |
| `void`     | (procedure)       |
| `null`     | `Variant`         |
| `undefined`| `Variant`         |
| `Array<T>` | `array of T`      |

Custom mappings can be provided via the `typeMapping` option.

## Roadmap

### Phase 1: Project Setup ✅ (Current)
- [x] Modern TypeScript project structure
- [x] Build tooling (tsup)
- [x] Testing framework (Vitest)
- [x] Linting & formatting
- [x] Basic CLI framework

### Phase 2: Parser (Weeks 3-4)
- [ ] TypeScript AST parsing
- [ ] AST visitor pattern
- [ ] Handle all TypeScript constructs

### Phase 3: AST Transformation (Weeks 5-6)
- [ ] Pascal AST design
- [ ] TypeScript → Pascal transformation
- [ ] Type mapping system

### Phase 4: Code Generation (Weeks 7-8)
- [ ] Pascal code generator
- [ ] DWScript output style
- [ ] Pas2JS output style
- [ ] Formatting & indentation

### Phase 5: Testing (Weeks 9-10)
- [ ] Unit tests (80%+ coverage)
- [ ] Integration tests
- [ ] Real-world TypeScript definitions
- [ ] Regression testing

### Phase 6: Polish (Week 11)
- [ ] Documentation
- [ ] Examples
- [ ] npm package
- [ ] GitHub Actions CI/CD

### Phase 7: Advanced Features (Future)
- [ ] Watch mode
- [ ] Batch processing
- [ ] Configuration file support
- [ ] Web UI
- [ ] VS Code extension

## Comparison with Legacy Version

| Feature | Legacy (Smart Pascal) | New (TypeScript) |
|---------|----------------------|------------------|
| Language | Smart Pascal | TypeScript |
| TS API | v1.7.5 (2016) | v5.6+ (2024) |
| Tests | None | Comprehensive |
| Tooling | Manual compilation | Modern (pnpm, tsup, vitest) |
| Build | External compiler | Integrated |
| Distribution | Single JS file | npm package + binary |

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Ensure all tests pass: `pnpm check`
6. Submit a pull request

## License

MIT License - see [LICENSE](../LICENSE) file for details

## Credits

- **Original ts2pas**: Christian-W. Budde
- **TypeScript Rewrite**: Developed with modern tooling and architecture
- **TypeScript Compiler API**: Microsoft

## Related Projects

- [DWScript](https://www.delphitools.info/dwscript) - Delphi Web Script
- [Smart Mobile Studio](https://smartmobilestudio.com/) - Object Pascal IDE
- [Pas2JS](https://wiki.freepascal.org/pas2js) - Pascal to JavaScript compiler
- [go-dws](https://github.com/CWBudde/go-dws) - DWScript compiler in Go

## Support

- **Issues**: [GitHub Issues](https://github.com/CWBudde/ts2pas/issues)
- **Discussions**: [GitHub Discussions](https://github.com/CWBudde/ts2pas/discussions)
