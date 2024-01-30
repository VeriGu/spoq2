#include <stdbool.h>
typedef unsigned long long u64;
typedef unsigned u32;
typedef unsigned char u8;

void iasm_239(u64 in0)
{
    asm volatile("msr S3_4_C12_C12_6, %0":  : "r" (in0));
}
