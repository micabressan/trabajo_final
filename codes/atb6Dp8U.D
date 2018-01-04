int main (string[] args) {
    auto f = delegate int(int x) {
        return x * cast(int) args.length;
    };
    return f(10);
}