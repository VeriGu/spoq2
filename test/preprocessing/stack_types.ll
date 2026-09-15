; Allocas of each interesting type.  ExtractPointers turns the set of distinct
; stack value types into the StackVal inductive in machine.v, which is where its
; own type mapping shows up -- ExtractBasics' mapping does not reach here.

%struct.Two = type { i32, i32 }

define void @use() {
entry:
  %a_i32    = alloca i32, align 4
  %a_i64    = alloca i64, align 8
  %a_ptr    = alloca ptr, align 8
  %a_float  = alloca float, align 4
  %a_double = alloca double, align 8
  %a_arr_i  = alloca [4 x i32], align 16
  %a_arr_d  = alloca [4 x double], align 16
  %a_arr_a  = alloca [2 x [3 x i32]], align 16
  %a_struct = alloca %struct.Two, align 4
  %a_vec_d  = alloca <2 x double>, align 16
  %a_vec_f  = alloca <4 x float>, align 16
  ret void
}
