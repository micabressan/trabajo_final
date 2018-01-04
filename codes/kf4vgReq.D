struct Ti {
    string t;
    string[] f;
}

void foo(Ti[] arr) {
    arr ~= Ti("foo", ["bar1", "bar2"]);
}

void main() {
    import std.range;

    Ti[] arr;
    foo(arr);

    assert(!arr.empty);
}