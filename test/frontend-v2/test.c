int add(int a, int b) {
    return a + b;
}

int add_one(int a) {
    return add(a, 1);
}

int main() {
    add_one(1);
}