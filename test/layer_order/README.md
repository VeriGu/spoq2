# Layer order and forward references between specs

## `callee_in_higher_layer`

**This case currently fails.** Kept as the fix target.

`vuln` and `patch` call `helper2`, which is declared in the layer *above* them.
Layers are inferred bottom-up, so the callers' specs are built while
`helper2_spec` does not yet exist:

    Infer spec task: patch
    Failed to infer type for patch_spec_low: unknown expr op (helper2_spec st).
        Delaying inference.
    ...
    what(): (z3_eval) Unknown symbol: helper2_spec

`add_definition` (`src/libs/project.cpp`) catches the inference failure and sets
`deleyed_type_inference`, and `spec_prover` retries it when that definition's own
task comes round. Neither helps here:

  - deferring inference does not stop the body being transformed, so `z3_eval`
    is reached with the callee still undefined;
  - retrying during the same task cannot succeed, since the callee is defined a
    layer later.

`z3_eval` also throws a plain `std::runtime_error`, where the deferral path
catches `TypeInferenceException`, so the two do not meet.

Reduced from ffm001, where `sws_getContext_vuln` sits in Layer1 and the
`sws_init_context_vuln` it calls sits in Layer5. Bisected to `6abe8e6`.

`helper`, called by the same functions from the layer below, is the control: it
resolves normally.
