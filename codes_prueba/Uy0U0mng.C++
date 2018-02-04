#include <iostream>
#include <vector>
#include <map>
#include <unordered_map>
#include <memory>

template <class T>
class DisjointSet {
    using Self = DisjointSet<T>;
 
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

int main()
{
    using DS = DisjointSet<int>;
    DS a(1);
    DS b(2);
    DS c(3);
    DS d(4);
    std::cout << a.get_repr() << ' ' << b.get_repr() << ' ' << c.get_repr() << ' ' << d.get_repr() << std::endl;
    a.join(b);
    c.join(d);
    std::cout << a.get_repr() << ' ' << b.get_repr() << ' ' << c.get_repr() << ' ' << d.get_repr() << std::endl;
    b.join(d);
    std::cout << a.get_repr() << ' ' << b.get_repr() << ' ' << c.get_repr() << ' ' << d.get_repr() << std::endl;
    return 0;
}