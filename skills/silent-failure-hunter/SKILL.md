# Silent Failure Hunter

Review code for silent failures, swallowed errors, bad fallbacks, and missing error propagation.

## When to Use

- After writing code that handles errors, exceptions, or fallbacks
- During code review for error handling patterns
- When debugging issues where errors are not being reported
- Before merging code that touches error handling logic

## Detection Checklist

### Critical Patterns

**Empty catch blocks:**
```javascript
// ❌ Silent failure
try { ... } catch (e) { }
try { ... } catch (e) { /* ignored */ }
```

**Error swallowing:**
```javascript
// ❌ Lost error context
try { ... } catch (e) { return null; }
try { ... } catch (e) { return defaultValue; }
```

**Missing error propagation:**
- API calls without error handling
- Async operations without .catch()
- File operations without error checks

**Bad fallbacks:**
- Critical operations fail silently
- Data validation failures use defaults
- Connection failures don't notify user

### Language-Specific Patterns

**JavaScript/TypeScript:**
- Empty catch blocks
- Promise chains without .catch()
- Async functions without try/catch
- Unhandled promise rejections

**Python:**
- Bare `except:` clauses
- Catching `Exception` and returning None
- Ignoring specific exceptions silently

**Go:**
- Ignoring error return values with `_`
- Not wrapping errors with context
- Returning nil instead of error

## Severity Classification

| Type | Severity | Description |
|------|----------|-------------|
| Empty catch | CRITICAL | Completely hides errors |
| Error swallowing | HIGH | Loses error context |
| Missing propagation | HIGH | Callers can't detect failure |
| Bad fallback | MEDIUM | Silently uses potentially wrong data |

## Fix Patterns

| Pattern | Fix |
|---------|-----|
| Empty catch | At minimum, log the error |
| Error swallowing | Return Result type or re-throw |
| Missing propagation | Add error handling chain |
| Bad fallback | Notify user or retry |
| Promise no catch | Add .catch() or try/catch |

## Example Fixes

```javascript
// ✅ Proper error handling
try {
  await riskyOperation();
} catch (error) {
  logger.error('Operation failed', { error, context });
  throw new AppError('Operation failed', { cause: error });
}

// ✅ Result pattern
function riskyOperation(): Result<Data, Error> {
  try {
    return { success: true, data: doSomething() };
  } catch (error) {
    return { success: false, error };
  }
}
```

## Related Skills

- `error-handling` - General error handling patterns
- `safety-guard` - Preventing destructive operations
- `gateguard` - Fact-forcing gate for quality
