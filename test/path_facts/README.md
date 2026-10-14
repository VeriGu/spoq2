# path_facts/

Facts on the path decide conditions without Z3 (`PathLiterals` in
`z3_utils.cpp`).  A negated disjunction on the path, such as an unfolded
`~ (is_stack_ptr p)`, also contributes the negation of each disjunct, so it
refutes each slot comparison, any disjunction of them, and any conjunction
containing one.  The inference is propositional: it uses whatever
`is_stack_ptr` unfolds to and nothing when it is uninterpreted.

Each case loads at an offset from the argument `p` in a function with three
stack slots of different value types.

| case | `main.v` | expected |
|---|---|---|
| `not_stack_ptr` | `Hint InitRely f_vuln (~ (is_stack_ptr p))` | the transformed spec keeps no stack arm |
| `no_fact` | no fact about `p` | the stack arms remain |
| `custom_is_stack_ptr` | the fact, with `is_stack_ptr` defined as a conjunction that excludes no slot | the stack arms remain |

`custom_is_stack_ptr` guards against a rule that reads `~ (is_stack_ptr p)` as
"the base is not a stack slot" whatever the definition says.

The `main.v` files are written by `../stack_frame/src/mk_fixture.sh`; the facts
and the replaced definition are appended or edited by hand.
