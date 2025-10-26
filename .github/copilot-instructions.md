# ts2pas Copilot Instructions

## Project Overview

ts2pas is a TypeScript-to-Pascal transpiler that converts TypeScript definition files (`.d.ts`) to DWScript-compatible Pascal code. The architecture follows a classic compiler pipeline: parse → transform → generate.

## Core Architecture

### Three-Stage Pipeline

1. **Parser** (`src/parser/`) - Uses TypeScript Compiler API to parse `.d.ts` files
2. **AST Transformation** (`src/ast/`) - Converts TypeScript AST to Pascal AST using visitor pattern
3. **Code Generation** (`src/codegen/`) - Generates formatted Pascal code from Pascal AST

### Key Directories

- `src/parser/` - TypeScript parsing with declaration extraction
- `src/ast/` - AST transformation via `TypeScriptToPascalTransformer` class
- `src/codegen/` - Pascal code generation via `PascalCodeGenerator` class
- `src/types.ts` - Pascal AST node definitions (PascalUnit, PascalClass, etc.)
- `src/cli.ts` - CLI with watch mode, batch processing, GitHub URL fetching
- `tests/` - Comprehensive test suite with regression testing

## Essential Patterns

### AST Node Pattern

All Pascal AST nodes extend `PascalNode` and implement `toCode(indentation: number): string`:

```typescript
export class PascalClass extends PascalNode {
  toCode(indentation = 0): string {
    const indent = ' '.repeat(indentation);
    // Generate Pascal class code
  }
}
```

### Type Mapping System

The `TypeHandler` class (`src/parser/types.ts`) handles TypeScript → Pascal type conversions:

- `string` → `String`
- `number` → `Integer` or `Float`
- `boolean` → `Boolean`
- Custom mappings via `typeMapping` config option

### Configuration Cascade

CLI options override config file options override defaults:

1. `ts2pas.config.json` (auto-discovered)
2. CLI flags (`--indent`, `--style`, etc.)
3. Defaults in `src/config/index.ts`

## Testing Strategy

### Test Structure (169 tests, 89.91% coverage)

- `tests/integration.test.ts` - End-to-end conversion tests
- `tests/ast.test.ts` - AST transformation unit tests
- `tests/parser.test.ts` - TypeScript parsing tests
- `tests/codegen.test.ts` - Pascal code generation tests
- `tests/regression.test.ts` - Baseline comparison tests
- `tests/real-world.test.ts` - Tests with actual library definitions

### Regression Testing

Uses baseline comparison in `tests/fixtures/baselines/`:

```bash
npm run generate-baselines  # Update expected outputs
npm run test:regression     # Compare against baselines
```

## Development Workflows

### Build & Test Commands

```bash
npm run dev          # Watch mode build
npm run build        # Production build
npm test             # Run all tests
npm run test:coverage # Coverage report
npm run test:regression # Regression tests only
npm run lint         # ESLint
npm run format       # Prettier
npm run check        # All checks (typecheck + lint + format + test)
```

### CLI Testing Patterns

Test CLI via integration tests, not unit tests of `cli.ts`. Use sample files in `tests/fixtures/input/`.

### Adding New TypeScript Features

1. Add parser support in `src/parser/index.ts` → `DeclarationExtractor.visit()`
2. Add AST transformation in `src/ast/index.ts` → `TypeScriptToPascalTransformer`
3. Add Pascal AST node in `src/types.ts` with `toCode()` method
4. Add tests covering the feature end-to-end
5. Update baselines if needed

## Project-Specific Conventions

### Indentation Handling

- AST nodes use 2-space indentation by default
- `PascalCodeGenerator.adjustIndentation()` scales to configured indent size
- Always pass `indentation` parameter through recursive `toCode()` calls

### Error Handling

- Parser errors → TypeScript diagnostics in `ParseResult.diagnostics`
- Conversion errors → thrown exceptions with descriptive messages
- CLI errors → user-friendly messages with optional `--verbose` stack traces

### External Classes Pattern

DWScript requires `external` class declarations. Control via `externalClasses` option (default: true):

```pascal
type
  TMyClass = class external 'MyClass'
    // methods and properties
  end;
```

### Unit Name Generation

File names are sanitized for Pascal identifiers:

- `my-module.d.ts` → `unit JS_My_module;`
- Numeric prefixes get `U_` prefix
- Non-alphanumeric chars become underscores

## Integration Points

### TypeScript Compiler API

Direct dependency on `typescript` package. Use official TS parser for accuracy, not custom parsing.

### GitHub URL Support

CLI auto-converts GitHub blob URLs to raw.githubusercontent.com URLs for fetching `.d.ts` files.

### Configuration Discovery

Auto-discovers `ts2pas.config.json` in current directory or specified via `--config`.

## Testing Real-World Libraries

Test against actual DefinitelyTyped definitions:

```bash
npx ts2pas --url https://github.com/DefinitelyTyped/DefinitelyTyped/blob/master/types/lodash/index.d.ts
```

Files in `tests/fixtures/real-world/` contain simplified versions of popular library definitions for testing.
