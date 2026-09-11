/* The mirror of unfold_not_needed.c: here the proof DOES need helper's body.

   The two files differ by one character -- which global helper writes.

     unfold_not_needed.c:  helper writes g2, which neither side reads, so its
                           effect cancels and the proof goes through with
                           helper left as an uninterpreted call.
     unfold_needed.c:      helper writes g, which vuln reads back.  With helper
                           folded, vuln returns an opaque load and patch returns
                           5, and they cannot be equated.  The demand-driven
                           retry inlines helper, g becomes 5, and the refinement
                           succeeds.

   unfold_needed_nounfold.main.v is this same module with

       Hint NoUnfold helper_spec.

   which must stop that retry from unfolding it -- so the proof is expected to
   FAIL there, with helper_spec still a call in the emitted spec.  The pair is
   the point: without the hint the retry fires and succeeds, with the hint the
   unfolding is suppressed and it does not. */
int g;

__attribute__((noinline)) void helper(void) { g = 5; }

int vuln(void)  { helper(); return g; }
int patch(void) { helper(); return 5; }
