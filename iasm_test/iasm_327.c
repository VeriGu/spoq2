#include <stdbool.h>
typedef unsigned long long u64;
typedef unsigned u32;
typedef unsigned char u8;

void iasm_327(u64 in0)
{
    asm volatile("msr sp_el1, %0":  : "r" (in0));
}
