/* The proof must not need helper's body.

   Both sides call helper() first, from the same state, so with helper left
   uninterpreted its result state is the same opaque term on both sides; the
   vuln/patch divergence (read g back vs. fold to the constant) happens after,
   on that shared state, and is decided by the store to g alone.

   helper writes an unrelated global, g2.  If spoq unfolded it anyway, the entry
   spec would carry that store (a `g_g2` field write) and the call would vanish.
   The fixture asserts the opposite: the entry body still names helper_spec as
   a call, and never mentions g_g2. */
int g;
int g2;

void helper(void) { g2 = 7; }

int vuln(void)  { helper(); g = 5; return g; }
int patch(void) { helper(); g = 5; return 5; }
