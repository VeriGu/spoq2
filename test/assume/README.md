# assume/

`llvm.assume(b)` with `b` false is undefined behaviour, so its spec is
`if b then Some st else None`.  The patchverification pipeline emitted
`... : (option RData) := st`, which returns a state where an option is
declared.  Inlined under a `when`, that body put a state under a `Some`
pattern, and the refinement check dereferenced a null `IndValue`
(mruby cve-2022-0570, exit 139 after 40-80 minutes).  `rule_unfold_specs` now
rejects a definition that returns an argument unwrapped where its result type
is an option.

| test | `llvm_assume_spec` | expected | discriminates |
|---|---|---|---|
| `assume_call` | `if b then Some st else None` | `verified: true` | the vuln assumes `x > 0` and the patch returns 0 otherwise; with `Some st` the result is `false` |
| `assume_ill_typed` | `st` | spoq exits with `Definition llvm_assume_spec returns its argument st ...` | without the check, refinement crashes |
