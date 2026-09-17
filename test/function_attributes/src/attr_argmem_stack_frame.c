/* The stack clause of the argmem frame, slot by slot.

   The callee is handed one stack pointer, so every stack slot except the one it
   names is pinned, the same way every heap block except the one an argument
   names is.  `other` is a different slot the callee was never given the address
   of, so it is still 7 afterwards.

   Its address is handed to the callee once before it is set, so that it is a
   real slot in the stack map rather than a value spoq can keep out of it:
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
