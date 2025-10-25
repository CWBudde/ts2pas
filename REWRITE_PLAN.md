# ts2pas Rewrite Plan

## Executive Summary

After thorough analysis of the current ts2pas implementation and evaluation of three potential rewrite options (Go, TypeScript, DWScript/go-dws), **TypeScript is the recommended approach** for rewriting ts2pas.

**Key Recommendation:** Rewrite in TypeScript with modern tooling and architecture.

---

## Current State Analysis

### Overview
- **Current Implementation:** Smart Pascal → Compiled JavaScript (Node.js)
- **Codebase Size:** ~6,113 lines of Pascal source code
- **Complexity:** 56+ type definition classes, 122+ methods
- **Dependencies:** TypeScript compiler API (v1.7.5 - very outdated)
- **Status:** Functional but marked "not ready for production use"

### Architecture
The current implementation uses:
1. **TTranslator Class** - Recursive descent parser (~2,000 lines)
2. **Declaration Classes** - 56+ classes representing TypeScript/Pascal AST nodes (~1,849 lines)
3. **TypeScript AST Definitions** - TypeScript syntax constants (~1,840 lines)
4. **Main Entry Point** - CLI and file I/O (~225 lines)

### Strengths
- Well-structured class hierarchy
- Proven against 60+ real-world TypeScript definitions
- Minimal dependencies
- Active development with recent improvements

### Weaknesses
- Outdated TypeScript compiler API (v1.7.5 from 2016)
- No automated tests
- Dual-language complexity (Pascal → JavaScript compilation)
- Build process requires external Smart Pascal compiler
- No modern tooling (no bundler, linter, formatter)

---

## Option Evaluation

### Option 1: Rewrite in Go ⭐⭐⭐

**Pros:**
- Fast compiled binary with no runtime dependencies
- Excellent standard library and tooling (go fmt, go test, go mod)
- Easy cross-platform distribution (single binary)
- Strong type system and error handling
- Great performance for parsing/processing tasks
- Growing ecosystem

**Cons:**
- No native TypeScript parser - would need to:
  - Use TypeScript via Node.js subprocess (hacky)
  - Port TypeScript parser to Go (massive effort)
  - Use third-party Go TypeScript parser (limited/incomplete options)
- Steeper learning curve for TypeScript AST manipulation
- Smaller ecosystem for compiler/transpiler tooling
- Would require significant research and development time

**Verdict:** Good for performance and distribution, but TypeScript AST parsing would be challenging. **Not recommended** unless performance is critical.

---

### Option 2: Rewrite in TypeScript ⭐⭐⭐⭐⭐

**Pros:**
- **Native TypeScript compiler API** - first-class support
- Modern, up-to-date TypeScript parser (current version 5.x)
- Rich ecosystem for compiler/transpiler tools
- Excellent TypeScript AST documentation and tooling
- Can use modern JavaScript features (async/await, modules, etc.)
- Superior development experience:
  - Type safety
  - IntelliSense/autocompletion
  - Refactoring tools
- Easy testing with Jest, Vitest, or similar
- Modern build tools (esbuild, tsup, Rollup)
- Can still distribute as single compiled file with bundlers
- Easier for contributors (widely known language)
- Package management with npm/pnpm/yarn

**Cons:**
- Requires Node.js runtime (but already does)
- Slightly larger distribution size vs Go binary
- TypeScript/JavaScript performance slower than Go (but sufficient for this task)

**Verdict:** **STRONGLY RECOMMENDED** - Natural fit for parsing TypeScript, modern tooling, easier maintenance.

---

### Option 3: Rewrite in DWScript with go-dws ⭐

**Pros:**
- Pascal-like syntax familiar to original codebase
- Could theoretically leverage go-dws compiler
- Interesting technical challenge

**Cons:**
- **go-dws is NOT production-ready:**
  - Explicitly marked "🚧 Work in Progress"
  - Only 76.3% complete (Stage 7/10)
  - Missing critical features:
    - ❌ Exception handling
    - ❌ Module/unit system
    - ❌ Generics
    - ❌ Operator overloading
    - ❌ Most built-in functions
- No TypeScript parsing capability
- Would need to wait months/years for go-dws maturity
- Very limited ecosystem
- Would be dependent on single-developer project
- No community support or libraries

**Verdict:** **NOT RECOMMENDED** - go-dws is too immature. Revisit in 1-2 years if project matures.

---

## Recommended Approach: TypeScript Rewrite

### Phase 1: Project Setup & Foundation (Week 1-2)

**Goals:**
- Set up modern TypeScript project structure
- Establish build pipeline and tooling
- Create basic CLI framework

**Tasks:**
1. Initialize new TypeScript project
   ```bash
   npm init -y
   npm install -D typescript @types/node
   npm install typescript  # Runtime dependency for compiler API
   ```

2. Configure modern tooling:
   - **TypeScript** (tsconfig.json with strict mode)
   - **Build:** esbuild or tsup for fast compilation
   - **Linter:** ESLint with TypeScript rules
   - **Formatter:** Prettier
   - **Test Framework:** Vitest or Jest
   - **Package Manager:** pnpm (faster than npm)

3. Set up project structure:
   ```
   ts2pas-rewrite/
   ├── src/
   │   ├── cli.ts              # CLI entry point
   │   ├── parser/             # TypeScript AST parsing
   │   ├── ast/                # Internal AST representation
   │   ├── codegen/            # Pascal code generation
   │   └── utils/              # Utilities
   ├── tests/
   │   ├── fixtures/           # Test .d.ts files
   │   └── *.test.ts
   ├── package.json
   ├── tsconfig.json
   └── README.md
   ```

4. Create basic CLI framework using commander or yargs:
   ```typescript
   ts2pas input.d.ts [output.pas]
   ts2pas --url <github-url>
   ```

**Deliverables:**
- ✅ Modern TypeScript project with strict configuration
- ✅ Build pipeline that produces single executable
- ✅ Basic CLI argument parsing
- ✅ Development scripts (dev, build, test, lint)

---

### Phase 2: TypeScript AST Parser (Week 3-4)

**Goals:**
- Leverage TypeScript Compiler API to parse .d.ts files
- Create robust AST traversal framework

**Tasks:**
1. Create TypeScript parser wrapper:
   ```typescript
   import * as ts from 'typescript';

   export class TypeScriptParser {
     parseDefinitionFile(content: string): ts.SourceFile {
       return ts.createSourceFile(
         'temp.d.ts',
         content,
         ts.ScriptTarget.Latest,
         true
       );
     }
   }
   ```

2. Implement AST visitor pattern:
   ```typescript
   export class ASTVisitor {
     visitSourceFile(node: ts.SourceFile): void;
     visitClassDeclaration(node: ts.ClassDeclaration): void;
     visitInterfaceDeclaration(node: ts.InterfaceDeclaration): void;
     visitFunctionDeclaration(node: ts.FunctionDeclaration): void;
     // ... etc
   }
   ```

3. Handle TypeScript-specific features:
   - Generic types
   - Union types
   - Intersection types
   - Mapped types
   - Conditional types
   - Type aliases
   - Namespaces/modules

**Deliverables:**
- ✅ Parser that converts TypeScript .d.ts → TypeScript AST
- ✅ Visitor pattern for traversing AST nodes
- ✅ Unit tests for various TypeScript constructs

---

### Phase 3: Internal AST Representation (Week 5-6)

**Goals:**
- Design clean internal AST representation
- Map TypeScript concepts to Pascal concepts

**Tasks:**
1. Define Pascal-oriented AST nodes:
   ```typescript
   // Base types
   export abstract class PascalNode {
     abstract toCode(indentation: number): string;
   }

   export class PascalUnit extends PascalNode {
     constructor(
       public name: string,
       public declarations: PascalDeclaration[]
     ) {}
   }

   export class PascalClass extends PascalNode {
     constructor(
       public name: string,
       public ancestors: string[],
       public members: PascalMember[]
     ) {}
   }

   // ... etc
   ```

2. Create transformation layer:
   ```typescript
   export class TypeScriptToPascalTransformer {
     transform(tsNode: ts.Node): PascalNode;
   }
   ```

3. Implement type mapping:
   - `string` → `String`
   - `number` → `Float` or `Integer`
   - `boolean` → `Boolean`
   - `any` → `Variant`
   - `Array<T>` → `array of T`
   - Union types → appropriate Pascal representation
   - Generic types → Pascal generics

**Deliverables:**
- ✅ Clean internal AST representation
- ✅ Transformer from TypeScript AST → Pascal AST
- ✅ Type mapping system
- ✅ Unit tests for transformations

---

### Phase 4: Code Generation (Week 7-8)

**Goals:**
- Generate clean, properly formatted Pascal code
- Handle edge cases and special constructs

**Tasks:**
1. Implement code generators for each Pascal AST node:
   ```typescript
   export class PascalCodeGenerator {
     generateUnit(unit: PascalUnit): string;
     generateClass(cls: PascalClass, indent: number): string;
     generateInterface(intf: PascalInterface, indent: number): string;
     generateFunction(fn: PascalFunction, indent: number): string;
     // ... etc
   }
   ```

2. Handle formatting:
   - Proper indentation (2 or 4 spaces)
   - Line length management
   - Comment preservation
   - Forward declarations
   - Namespace management

3. Implement special features:
   - External class declarations
   - DWScript-specific attributes
   - Overload handling
   - Optional parameter handling

**Deliverables:**
- ✅ Complete code generator
- ✅ Properly formatted Pascal output
- ✅ Support for DWScript external classes
- ✅ Unit tests comparing output to expected Pascal code

---

### Phase 5: Testing & Validation (Week 9-10)

**Goals:**
- Comprehensive test coverage
- Validate against real-world TypeScript definitions

**Tasks:**
1. Create test suite structure:
   ```
   tests/
   ├── unit/                  # Unit tests for individual components
   ├── integration/           # End-to-end tests
   └── fixtures/
       ├── input/             # Sample .d.ts files
       └── expected/          # Expected .pas output
   ```

2. Test against real-world definitions:
   - jQuery
   - d3
   - React
   - Node.js
   - TypeScript standard library
   - All 60+ previously tested libraries

3. Create regression test suite:
   - Save known-good outputs
   - Compare new outputs against baselines
   - Flag any differences

4. Set up CI/CD:
   - GitHub Actions for automated testing
   - Code coverage reporting (aim for >80%)
   - Automated releases

**Deliverables:**
- ✅ Comprehensive test suite (>80% coverage)
- ✅ Validation against 60+ real-world libraries
- ✅ CI/CD pipeline
- ✅ Regression testing framework

---

### Phase 6: CLI & Distribution (Week 11)

**Goals:**
- Polished CLI experience
- Easy installation and distribution

**Tasks:**
1. Enhance CLI features:
   ```typescript
   ts2pas input.d.ts [output.pas]            # Basic usage
   ts2pas --url <github-url>                 # Fetch from GitHub
   ts2pas --watch input.d.ts                 # Watch mode
   ts2pas --batch *.d.ts                     # Batch processing
   ts2pas --config ts2pas.config.json        # Configuration file
   ```

2. Add configuration support:
   ```json
   {
     "indentation": 2,
     "outputStyle": "dws",
     "typeMapping": {
       "number": "Float"
     },
     "namespacePrefix": "JS"
   }
   ```

3. Create distribution packages:
   - npm package: `npm install -g @cwbudde/ts2pas`
   - Single-file executable using `@vercel/ncc` or `esbuild`
   - Optional: compile to native using Bun or Deno

4. Write documentation:
   - Updated README.md
   - API documentation
   - Migration guide from old ts2pas
   - Examples and tutorials

**Deliverables:**
- ✅ Feature-complete CLI
- ✅ npm package published
- ✅ Comprehensive documentation
- ✅ Migration guide

---

### Phase 7: Advanced Features (Week 12+)

**Goals:**
- Add quality-of-life features
- Performance optimization

**Optional Tasks:**
1. **Watch Mode:** Auto-regenerate when .d.ts files change
2. **Incremental Updates:** Only regenerate changed modules
3. **Source Maps:** Map Pascal code back to TypeScript definitions
4. **LSP Integration:** Language server for editor support
5. **Web UI:** Browser-based conversion tool
6. **VS Code Extension:** Convert .d.ts files in editor
7. **Performance Optimization:**
   - Parallel processing for multiple files
   - Caching of parsed ASTs
   - Worker threads for large files

**Deliverables:**
- ✅ Selected advanced features implemented
- ✅ Performance benchmarks
- ✅ User feedback incorporated

---

## Migration Strategy

### Backwards Compatibility
1. **Output Compatibility:** Ensure new tool generates compatible Pascal code
2. **CLI Compatibility:** Maintain same basic CLI arguments
3. **Side-by-Side Testing:** Run both old and new versions, compare outputs

### Transition Plan
1. **Alpha Release** (Week 10): Internal testing
2. **Beta Release** (Week 11): Community testing, gather feedback
3. **RC Release** (Week 12): Final testing, documentation complete
4. **v1.0 Release** (Week 13): Production release, deprecate old tool

### Repository Strategy
**Option A:** New Repository
- Create `ts2pas-next` or `ts2pas2` repository
- Keep old version accessible
- Eventually merge/archive old repo

**Option B:** Same Repository (Recommended)
- Create `rewrite-typescript` branch
- Keep old code in `legacy` branch
- Merge to `main` when ready
- Tag final old version as `v0.5.0-legacy`

---

## Success Criteria

### Minimum Viable Product (MVP)
- ✅ Parses TypeScript .d.ts files using modern TypeScript compiler API
- ✅ Generates valid DWScript Pascal code
- ✅ Supports classes, interfaces, functions, types, generics
- ✅ CLI with same basic features as current version
- ✅ Passes tests with 50+ real-world TypeScript definitions
- ✅ Basic documentation

### Full Release (v1.0)
- ✅ All MVP criteria
- ✅ 80%+ test coverage
- ✅ Passes tests with all 60+ previously tested libraries
- ✅ Performance equal or better than current version
- ✅ Complete documentation and examples
- ✅ Published npm package
- ✅ CI/CD pipeline

### Stretch Goals
- ✅ Watch mode
- ✅ Configuration file support
- ✅ VS Code extension
- ✅ Performance 2x faster than current version
- ✅ Web UI for online conversion

---

## Technology Stack (Recommended)

### Core
- **Language:** TypeScript 5.x
- **Runtime:** Node.js 18+ (LTS)
- **Package Manager:** pnpm

### Development
- **Build Tool:** tsup or esbuild
- **Test Framework:** Vitest
- **Linter:** ESLint with @typescript-eslint
- **Formatter:** Prettier
- **Type Checking:** TypeScript strict mode

### Dependencies
- **typescript:** ^5.3.0 (compiler API)
- **commander:** ^11.0.0 (CLI framework)
- **chalk:** ^5.0.0 (colored output)
- **ora:** ^7.0.0 (spinners)

### DevDependencies
- **@types/node:** Latest
- **vitest:** Latest
- **eslint:** Latest
- **prettier:** Latest
- **tsup:** Latest

---

## Risk Assessment

### Low Risk
- ✅ TypeScript compiler API is stable and well-documented
- ✅ Modern tooling is mature and reliable
- ✅ Similar projects exist as reference (ts-morph, etc.)

### Medium Risk
- ⚠️ Learning curve for TypeScript compiler API internals
- ⚠️ Maintaining output compatibility with old version
- ⚠️ Edge cases in TypeScript → Pascal type mapping

### Mitigation Strategies
1. **Incremental Development:** Build piece by piece with tests
2. **Reference Implementation:** Keep old code as reference
3. **Community Input:** Engage with users for feedback
4. **Comprehensive Testing:** Test against many real-world examples

---

## Timeline Summary

| Phase | Duration | Deliverable |
|-------|----------|-------------|
| 1. Setup | 1-2 weeks | Project structure, tooling |
| 2. Parser | 2 weeks | TypeScript AST parsing |
| 3. AST | 2 weeks | Internal representation |
| 4. Codegen | 2 weeks | Pascal code generation |
| 5. Testing | 2 weeks | Comprehensive tests |
| 6. CLI | 1 week | Polished CLI, distribution |
| 7. Advanced | Ongoing | Optional features |

**Total Estimated Time:** 10-12 weeks for MVP, 13+ weeks for full v1.0 release

---

## Conclusion

**Recommendation: Rewrite in TypeScript**

TypeScript is the clear winner for this rewrite because:

1. **Native TypeScript Support:** Direct access to TypeScript compiler API
2. **Modern Ecosystem:** Rich tooling, testing, and build infrastructure
3. **Maintainability:** Easier for contributors, better documentation
4. **Proven Approach:** Similar tools successfully use this stack
5. **Lower Risk:** Mature technology stack with extensive community support

**Not Recommended:**
- ❌ **Go:** TypeScript AST parsing would be difficult
- ❌ **DWScript/go-dws:** Tool not production-ready (only 76% complete)

**Next Steps:**
1. Approve this plan
2. Set up new TypeScript project structure
3. Begin Phase 1: Project Setup
4. Start with small proof-of-concept (parse single .d.ts file)
5. Iterate based on feedback

---

## Questions for Discussion

1. **Timeline:** Is 10-12 weeks acceptable? Can we parallelize any work?
2. **Scope:** Should we include advanced features (watch mode, web UI) in v1.0?
3. **Distribution:** npm-only or also provide standalone binaries?
4. **Compatibility:** How important is exact output matching with old version?
5. **Repository:** New repo or same repo with branch?
6. **Community:** Should we announce the rewrite and gather input early?

---

**Document Version:** 1.0
**Date:** 2025-10-24
**Author:** Claude (AI Assistant)
**Status:** Proposal for Review
