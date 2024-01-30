#include <stdbool.h>
typedef unsigned long long u64;
typedef unsigned u32;
typedef unsigned char u8;

void iasm_222(u64 in0)
{
    asm volatile("msr S3_4_C12_C9_0, %0":  : "r" (in0));
}
