#include <stdbool.h>
typedef unsigned long long u64;
typedef unsigned u32;
typedef unsigned char u8;

void iasm_191(u64 in0)
{
    asm volatile("tlbi ipas2e1is, %0":  : "r" (in0));
}
