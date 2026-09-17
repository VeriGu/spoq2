/* The stack clause of the argmem frame, and how coarse it is.  **Not
   implemented**: this asserts the right answer and reports a skip until spoq
   gives it.

   The callee is handed one stack pointer, so the frame's stack arm applies:
   is_stack_ptr p -> heap' = heap /\ globals' = globals.  Nothing is said about
   the rest of the stack.  `other` is a different slot the callee was never
   given the address of, yet the whole stack map is left unconstrained, so it is
   not provably still 7 -- though it plainly is, which is why the expected file
   asks for verified: true.

   Contrast attr_argmem_frame, the same shape reading a global instead: that one
   verifies, because globals are pinned whole.  Only the heap clause is stated
   block by block; the stack and globals are all-or-nothing.

   A per-slot stack frame -- stack' = stack except at p.(pbase) -- would make
   this verify, and would be the analogue of what the heap arm already does.

   `other`'s address is handed to the callee once before it is set, so that it
   is a real slot in the stack map rather than a value spoq can keep out of it:
   without that escape the store and the load fold together and the frame is
   never consulted.

   C has no attribute that spells this, so the .ll is edited by hand. */
int ext_argmem_stack_frame(int *p);

int vuln(void) {
    int local = 0;
    int other = 0;
    ext_argmem_stack_frame(&other);
    other = 7;
    ext_argmem_stack_frame(&local);
    return other;
}

int patch(void) {
    int local = 0;
    int other = 0;
    ext_argmem_stack_frame(&other);
    other = 7;
    ext_argmem_stack_frame(&local);
    return 7;
}
