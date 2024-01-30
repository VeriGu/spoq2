#include <stdbool.h>
typedef unsigned long long u64;
typedef unsigned u32;
typedef unsigned char u8;

void iasm_205(u64 in0)
{
    asm volatile("msr cntv_cval_el02, %0":  : "r" (in0));
}
