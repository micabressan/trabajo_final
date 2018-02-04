template <class T>
class DisjointSet {
    using Self = DisjointSet;

public:
    DisjointSet(T repr) : repr(repr), link(nullptr) {}

    bool operator==(const Self &other) const { return get_repr() == other.get_repr(); }

    bool operator!=(const Self &other) const { return not(*this == other); }

    void join(Self &other) {
        Self *s = &other, *d = this;
        while (s->link) {
            s = s->link;
        }
        while (d->link) {
            d = d->link;
        }
        if (d != s) {
            s->link = d;
        }
    }


    const T &get_repr() const {
        return get_root()->repr;
    }

private:
    const Self* get_root() const {
        const Self* result = this;
        while (result->link) {
            result = result->link;
        }
        return result;
    }
    const T repr;
    Self *link;
};