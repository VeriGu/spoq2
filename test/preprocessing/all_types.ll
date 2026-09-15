; One declaration per LLVM type, so each Parameter signature pins exactly one
; mapping, plus a record whose fields pin the struct-field mapping.  Both passes
; run over this; what they emit for each type is what the tests assert.

%struct.Fields = type { i1, i8, i32, i64, ptr, float, double,
                        [4 x i32], [4 x double], [4 x ptr],
                        <2 x double>, <4 x float> }

declare i32 @p_i1(i1)
declare i32 @p_i8(i8)
declare i32 @p_i32(i32)
declare i32 @p_i64(i64)
declare i32 @p_ptr(ptr)
declare i32 @p_float(float)
declare i32 @p_double(double)
declare i32 @p_vec2double(<2 x double>)
declare i32 @p_vec4float(<4 x float>)

declare void @r_void()
declare float @r_float()
declare double @r_double()
declare ptr @r_ptr()
declare <2 x double> @r_vec2double()

define i32 @use(ptr %p) {
entry:
  %s = load %struct.Fields, ptr %p, align 8
  ret i32 0
}
