               static VALUE
range_include(VALUE range, VALUE val)
{
    VALUE beg = RANGE_BEG(range);
    VALUE end = RANGE_END(range);
    int nv = FIXNUM_P(beg) || FIXNUM_P(end) ||
             rb_obj_is_kind_of(beg, rb_cNumeric) ||
             rb_obj_is_kind_of(end, rb_cNumeric);

    if (nv ||
        !NIL_P(rb_check_to_integer(beg, "to_int")) ||
        !NIL_P(rb_check_to_integer(end, "to_int"))) {
        if (r_le(beg, val)) {
            if (EXCL(range)) {
                if (r_lt(val, end))
                    return Qtrue;
            }
            else {
                if (r_le(val, end))
                    return Qtrue;
            }
        }
        return Qfalse;
    }
    else if (TYPE(beg) == T_STRING && TYPE(end) == T_STRING &&
             RSTRING_LEN(beg) == 1 && RSTRING_LEN(end) == 1) {
        if (NIL_P(val)) return Qfalse;
        if (TYPE(val) == T_STRING) {
            if (RSTRING_LEN(val) == 0 || RSTRING_LEN(val) > 1)
                return Qfalse;
            else {
                char b = RSTRING_PTR(beg)[0];
                char e = RSTRING_PTR(end)[0];
                char v = RSTRING_PTR(val)[0];

                if (ISASCII(b) && ISASCII(e) && ISASCII(v)) {
                    if (b <= v && v < e) return Qtrue;
                    if (!EXCL(range) && v == e) return Qtrue;
                    return Qfalse;
                }
            }
        }
    }
    /* TODO: ruby_frame->this_func = rb_intern("include?"); */
    return rb_call_super(1, &val);
}