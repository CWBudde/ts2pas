# Legacy Implementations

This directory contains the original implementations of ts2pas for reference and historical purposes.

## v1-nodejs

The original Node.js implementation (v0.5.0) written in JavaScript. This version used TypeScript 1.7.5 and had a simpler, more direct approach to parsing and conversion.

**Note**: This implementation is no longer maintained. For new projects, please use the v2 implementation at the repository root.

## v1-pascal

The original DWScript/Pascal implementation. This was an earlier version written in Object Pascal/DWScript.

**Note**: This implementation is preserved for reference only and is no longer actively maintained.

## Migration to v2

If you're upgrading from v1 to v2, please note the following changes:

1. **CLI Interface**: The basic CLI remains the same, but new options have been added
2. **Output Format**: The Pascal output should be similar but may have minor formatting differences
3. **Node.js Version**: v2 requires Node.js 18+ (v1 worked with older versions)
4. **Installation**: Use `@cwbudde/ts2pas` package name for v2

For detailed migration guidance, see the main [README.md](../README.md) in the repository root.
