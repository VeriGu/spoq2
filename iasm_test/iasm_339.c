#include <stdbool.h>
typedef unsigned long long u64;
typedef unsigned u32;
typedef unsigned char u8;

void iasm_339(u64 in0)
{
    asm volatile("msr vbar_el12, %0":  : "r" (in0));
}
