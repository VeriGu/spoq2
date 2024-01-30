#include <stdbool.h>
typedef unsigned long long u64;
typedef unsigned u32;
typedef unsigned char u8;

void iasm_345(u64 in0)
{
    asm volatile("msr S3_4_C1_C2_0, %0":  : "r" (in0));
}
