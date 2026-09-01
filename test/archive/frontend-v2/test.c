unsigned int add(unsigned int a, unsigned int b) {
    if(a == 0) return 0;
    else if (b == 1) return 2;
    a = 123;
    if(a + b > 100) return 100;
    else {
        if(a + b > 50) return 50;
        else if(a + b > 1) return a + b + 2;
    }
    return a + b;
}

unsigned add_one(unsigned int a) {
    return add(a, 1);
}

int main() {
    add_one(1);
}