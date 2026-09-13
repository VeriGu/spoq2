#include <stdlib.h>
#include <stdarg.h>

struct Data {
    int val;
    struct Data* next;
};

int result;
int peek_next_val(struct Data* d, int skip){
    if(skip){
        return d->next->val;
    } else {
        return d->val;
    }
}

int entry(struct Data* d) {
    if(d){
        return peek_next_val(d, 0);
    }
    return -1;
}
