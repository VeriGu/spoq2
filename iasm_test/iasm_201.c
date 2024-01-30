#include <stdbool.h>
typedef unsigned long long u64;
typedef unsigned u32;
typedef unsigned char u8;

void iasm_201(u64 in0)
{
    asm volatile("msr cntp_ctl_el02, %0":  : "r" (in0));
}
