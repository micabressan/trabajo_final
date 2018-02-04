template Repeat(T, int count)
{
    static if (!count)
    {
        alias Tuple!() Repeat;
    }
    else
    {
        alias Tuple!(T, Repeat!(T, count-1)) Repeat;
    }
}

struct Vector(flt_, int dim_)
{
    alias flt_ flt;
    const static int dim = dim_;

    static assert (dim >= 2 && dim <= 4);

    union
    {
        flt[dim] cellz;
        Repeat!(flt, dim) tuple;
        
        struct
        {
            static if (dim >= 1) union { flt x; flt r; }
            static if (dim >= 2) union { flt y; flt g; }
            static if (dim >= 3) union { flt z; flt b; }
            static if (dim >= 4) union { flt w; flt a; }
        }
    }


    static if (2 == dim) const static Vector zero = { x : 0, y : 0 };
    static if (3 == dim) const static Vector zero = { x : 0, y : 0, z : 0 };
    static if (4 == dim) const static Vector zero = { x : 0, y : 0, z : 0, w : 0 };
}