        void foo(int r) {
        }

        auto baz = delegate(int) {

        };

        void bar(void delegate(int) func) {
                func(3);
                func(3);
                func(3);
        }