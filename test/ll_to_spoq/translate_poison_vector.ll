; A vector built up from poison, which is what clang emits for _mm_load_sd and
; friends -- the shape snd014's d2alaw_array reaches through psf_lrint.
;
;   %vecinit = insertelement <2 x double> poison, double %0, i32 0
;
; The poison operand becomes a symbol named after the vector's width,
; `poison_vector_2`, and nothing declares it.  undef gets the same treatment
; under `undef_vector_<n>`.

define double @vuln(ptr %p, float %f) {
entry:
  %0 = load double, ptr %p, align 8
  %v0 = insertelement <2 x double> poison, double %0, i32 0
  %v1 = insertelement <2 x double> %v0, double 0.000000e+00, i32 1

  %u0 = insertelement <4 x float> undef, float %f, i32 0

  %r = fadd double %0, %0
  ret double %r
}
