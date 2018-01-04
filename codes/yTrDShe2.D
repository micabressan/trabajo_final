struct Ti {
    string t;
    string[] f;
}

void foo(Ti[] arr) {
    arr[0].t = "bar";
}

void main() {
    import std.range;

    Ti[] arr;
    arr ~= Ti("foo", ["bar1", "bar2"]);
    foo(arr);

    assert(arr[0].t == "bar");
}