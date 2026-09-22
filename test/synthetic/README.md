# Synthetic corpus cases

Four projects imported from the synthetic corpus
(`patchverification/examples/synthetic`), unchanged apart from the file names
the driver expects.

They are here because the suite and the corpus disagreed. While the bitvector
sorts were being brought up, ctest reached 48/48 several steps before the
corpus recovered, so "the suite passes" stopped meaning "the encoding works".
These four are the projects that differed under the flag longest, and with them
in the suite that gap is visible where it is measured.

| case | what it covers |
|---|---|
| `buf_static_string` | a refinement over a static string buffer |
| `buf_static_set` | the same shape, writing to it |
| `buf_static_const_string` | the same shape, read-only |
| `struct_basic` | a two-file project over a struct |

All four now give the same verdict under both encodings. They are the projects
carrying the `function call` and `zmap index` crossings reported by
`SPOQ_TRACE_SORTS`, i.e. the `.main.v`-declared boundary where a value has no
width, so they are the ones to check first when that boundary changes.
