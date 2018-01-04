#include <bits/stdc++.h>

using namespace std;

#define pb push_back
#define mp make_pair
#define fs first
#define sc second
#define fst first
#define snd second
#define sz(x) (int) ((x).size())
#define forn(i, n) for (int i = 0; (i) < (n); ++i)
#define fornr(i, n) for (int i = (n) - 1; (i) >= 0; --i)
#define forab(i, a, b) for (int i = (a); (i) < (b); ++i)
#define forba(i, a, b) for (int i = (b) - 1; (i) >= (a); --i)
#define forit(it, c) for (__typeof((c).begin()) it = (c).begin(); it != (c).end(); ++it)
#define all(c) (c).begin(), (c).end()

#ifdef LOCAL
#define eprintf(...) fprintf(stderr, __VA_ARGS__)
#else
#define eprintf(...) static_cast<void>(0)
#endif

#ifdef _WIN32
#define I64 "%I64d"
#else
#define I64 "%lld"
#endif

typedef long long ll;
typedef unsigned long long ull;
typedef long double ld;
typedef unsigned int uint;
typedef vector<int> vi;
typedef pair<int, int> pii;

#define FNAME "inside3"

const int MAX = 1e9;
const int MAX_DEGREE = 12;

struct Point {
    int x, y;
    Point(): x(0), y(0) {}
    Point(int _x, int _y): x(_x), y(_y) {}

    inline Point operator+(const Point &B) const {
        return Point(x + B.x, y + B.y);
    }
    inline Point operator-(const Point &B) const {
        return Point(x - B.x, y - B.y);
    }
    inline ll operator*(const Point &B) const {
        return x * 1ll * B.x + y * 1ll * B.y;
    } // LL
    inline ll operator%(const Point &B) const {
        return x * 1ll * B.y - y * 1ll * B.x;
    } // LL

    inline Point operator-() const {
        return Point(-x, -y);
    }

    inline void operator+=(const Point &B) {
        x += B.x, y += B.y;
    }
    inline void operator-=(const Point &B) {
        x -= B.x, y -= B.y;
    }
    inline void operator*=(int k) {
        x *= k, y *= k;
    }

    inline bool operator==(const Point &B) const {
        return x == B.x && y == B.y;
    }
    inline bool operator!=(const Point &B) const {
        return x != B.x || y != B.y;
    }
    inline bool operator<(const Point &B) const {
        return x == B.x ? y < B.y : x < B.x;
    }
    inline bool operator<=(const Point &B) const {
        return x == B.x ? y <= B.y : x < B.x;
    }

    inline double angle() const {
        return atan2(y, x);
    } // LD
    inline ll len2() const {
        return x * 1ll * x + y * 1ll * y;
    } // LL

    inline void read(){
        scanf("%d%d", &x, &y);
    }
    inline void write(){
        printf("%d %d\n", x, y);
    }
};

struct Vertex {
    Point p;
    int id;
    Vertex() {}
    Vertex(Point _p, int _id): p(_p), id(_id) {}

    inline bool operator<(const Vertex &v) const {
        return p == v.p ? id < v.id : p < v.p;
    }
    inline bool operator==(const Vertex &v) const {
        return p == v.p && id == v.id;
    }
};


struct Segment {
    Vertex v1, v2;
    Segment(){}
    Segment(Vertex v1, Vertex v2) {
        if (v1.id < v2.id) {
            this->v1 = v1;
            this->v2 = v2;
        } else {
            this->v1 = v2;
            this->v2 = v1;
        }
    }


    bool operator<(const Segment &s) const {
        if (v1 < s.v1 || s.v1 < v1)
            return v1 < s.v1;
        return v2 < s.v2;
    }
    bool operator==(const Segment &s) const {
        return v1 == s.v1 && v2 == s.v2;
    }

    bool containsPoint(const Vertex &v) const {
        return v.p == v1.p || v.p == v2.p || ((v.p - v1.p) % (v2.p - v1.p) == 0
                                              && max((v.p - v1.p).len2(), (v.p - v2.p).len2()) < (v2.p - v1.p).len2());
    }

    /*bool operator < (Segment b) {
        return (v1.id < b.v1.id) || ((v1.id == b.v1.id) && (v2.id < b.v2.id));
    }

    bool operator == (Segment b) {
        return (v1.id == b.v1.id) && (v2.id == b.v2.id);
    }*/
};

struct Triangle {
    Vertex v1, v2, v3;
    Triangle() {}
    Triangle(Vertex _v1, Vertex _v2, Vertex _v3): v1(_v1), v2(_v2), v3(_v3) {}

    bool operator<(const Triangle &t) const {
        if (v1 < t.v1 || t.v1 < v1)
            return v1 < t.v1;
        if (v2 < t.v2 || t.v2 < v2)
            return v2 < t.v2;
        return v3 < t.v3;
    }

    void print() const {
        printf("Triangle: (%d, %d) -- (%d, %d) -- (%d, %d)\n", v1.p.x, v1.p.y, v2.p.x, v2.p.y, v3.p.x, v3.p.y);
    }

    inline ll getArea() const {
        return (v2.p - v1.p) % (v3.p - v1.p);
    }
    inline ll getAbsArea() const {
        return abs(getArea());
    }
    vector<Vertex> getVertices() const {
        return {v1, v2, v3};
    }
    vector<Segment> getSegments() const {
        return {Segment(v1, v2), Segment(v1, v3), Segment(v2, v3)};
    }
    bool containsPointInside(const Vertex &v) const {
        if (getAbsArea() != Triangle(v1, v2, v).getAbsArea()
                            + Triangle(v1, v3, v).getAbsArea()
                            + Triangle(v2, v3, v).getAbsArea())
            return false;
        auto segments = getSegments();
        for (auto &segment : segments)
            if (segment.containsPoint(v))
                return false;
        return true;
    }
    bool containsPoint(const Vertex &v) const {
        return getAbsArea() == Triangle(v1, v2, v).getAbsArea()
                               + Triangle(v1, v3, v).getAbsArea()
                               + Triangle(v2, v3, v).getAbsArea();
    }
};


struct Triangulation {
    vector<Segment> edges;
    vector<Triangle> triangles;
    Triangulation() {}
    Triangulation(const vector<Segment> &_edges, const vector<Triangle> &_triangles):
            edges(_edges), triangles(_triangles) {}

    void merge(const Triangulation &triangulation) {
        edges.insert(edges.end(), triangulation.edges.begin(), triangulation.edges.end());
        triangles.insert(triangles.end(), triangulation.triangles.begin(), triangulation.triangles.end());
    }
};

struct TriangulationDetalization {
    vector<Triangle> triangles;
    vector<vector<int>> graph;
    int insideIdThreshold;
    TriangulationDetalization(vector<Triangle> _triangles, vector<vector<int>> _graph, int _insideIdThreshold):
            triangles(_triangles), graph(_graph), insideIdThreshold(_insideIdThreshold) {}

    bool isPointInside(const Point &p) const {
        unordered_set<int> visitedIds;
        return isPointInside(p, graph.size() - 1, visitedIds);
    }
    bool isPointInside(const Point &p, int id, unordered_set<int> &visitedIds) const {
        //printf("%d\n", id);
        if (graph[id].empty())
            return id < insideIdThreshold;
        bool result = 0;
        visitedIds.insert(id);
        for (int neighbour : graph[id]) {
            //printf("n=%d id=%d\n", neighbour, id);
            //triangles[neighbour].print();
            //printf("%d\n", triangles[neighbour].containsPoint(Vertex(p, 0)));
            if (triangles[neighbour].containsPoint(Vertex(p, 0)) && !visitedIds.count(neighbour))
                result |= isPointInside(p, neighbour, visitedIds);
        }
        return result;
    }
};

struct nbVert {
    Vertex v;
    Vertex n1, n2;

    int side;
    int order_id;

    bool operator < (nbVert u) {
        if (v.p.y != u.v.p.y) {
            return (v.p.y > u.v.p.y);
        }
        return (v.p.x < u.v.p.x);

        if (v.p.x != u.v.p.x) {
	    }

        if (side != u.side) {
            return side < u.side;
        }

        if (side == 0) {
            return order_id < u.order_id;
        } else {
            return order_id > u.order_id;
        }
    }

    bool operator > (nbVert u) {
        return u < *this;
    }
};


Triangulation triangulationYpoly(vector<Vertex> poly) {
    Triangulation res;

//    cerr << "TriangulationYpoly" << endl;
    vector<nbVert> polyn(poly.size());
    int mxId = 0;
    int mnId = 0;
    for (int i = 0; i < polyn.size(); ++i) {
        polyn[i].v = poly[i];
        polyn[i].n1 = poly[(i - 1 + poly.size()) % poly.size()];
        polyn[i].n2 = poly[(i + 1) % poly.size()];

        if (polyn[i] < polyn[mxId]) {
            mxId = i;
        }


        if (polyn[i] > polyn[mnId]) {
            mnId = i;
        }


        res.edges.push_back(Segment(poly[i], poly[(i + 1) % poly.size()]));
    }

    int j = 0;

    for (int i = mnId; i != mxId; ++j, i = (i + 1)%polyn.size()) {
        polyn[i].order_id = j;
        polyn[i].side = 1;
        if (i != mnId) {
            int pr = (i - 1 + polyn.size()) % polyn.size();
            if (polyn[pr].v.p.y > polyn[i].v.p.y)
            {
                for (auto p: poly)
                {
                    cerr << p.p.x << " " << p.p.y << endl;
                }
                cerr << i << " " << pr << " " << polyn[pr].v.p.y << " " << polyn[i].v.p.y;
                cerr << endl << mnId << " " << mxId << endl;

            }

            assert(polyn[pr].v.p.y <= polyn[i].v.p.y);
        }
    }


    for (int i = mxId; i != mnId; ++j, i = (i + 1)%polyn.size()) {
        polyn[i].order_id = j;
        polyn[i].side = 0;
        if (i != mxId) {
            int pr = (i - 1 + polyn.size()) % polyn.size();
            if (polyn[pr].v.p.y < polyn[i].v.p.y)
            {
                for (auto p: poly)
                {
                    cerr << p.p.x << " " << p.p.y << endl;
                }
                cerr << i << " " << pr << " " << polyn[pr].v.p.y << " " << polyn[i].v.p.y;
                cerr << endl << mnId << " " << mxId << endl;

            }

            assert(polyn[pr].v.p.y >= polyn[i].v.p.y);
        }
    }

    /* std::cerr << "DEBUG ";
     for (int i = 0; i < polyn.size(); ++i) {
         std::cerr << polyn[i].side << " " << polyn[i].order_id << ".. ";
     }
     std::cerr << "\n";*/

    sort(polyn.begin(), polyn.end());

    /*std::cerr<< "DEBUG ";
    for (int i = 0; i < (int)polyn.size(); ++i) {
        std::cerr << polyn[i].v.id << " ";
    }*/


    vector<nbVert> st;
    st.push_back(polyn[0]);
    st.push_back(polyn[1]);

    for (int i = 2; i < (int)polyn.size() - 1; ++i) {
        nbVert v = polyn[i];
        if (v.n1.id != st[(int)st.size() - 1].v.id &&
            v.n2.id != st[(int)st.size() - 1].v.id) {
            nbVert u = st[(int)st.size() - 1];

            for (int j = (int)st.size() - 1; j > 0; --j) {
                res.edges.push_back(Segment(v.v, st[j].v));
                res.triangles.push_back(Triangle(v.v, st[j].v, st[j - 1].v));
                st.pop_back();
            }
            st.pop_back();

            st.push_back(u);
            st.push_back(v);
        } else {
            int dir = 1;
            if (v.side == 0) {
                dir = -1;
            }

            for (int j = (int)st.size() - 1; j > 0 && ((v.v.p - st[j].v.p) % (v.v.p - st[j - 1].v.p)) * dir > 0; --j) {
                res.edges.push_back(Segment(v.v, st[j].v));
                res.triangles.push_back(Triangle(v.v, st[j].v, st[j - 1].v));
                st.pop_back();
            }

            res.edges.push_back(Segment(v.v, st[(int)st.size() - 1].v));

            st.push_back(v);
        }
    }

    nbVert v = polyn[(int)polyn.size() - 1];

    for (int j = (int)st.size() - 2; j >= 0; --j) {
        res.edges.push_back(Segment(v.v, st[j].v));
        res.triangles.push_back(Triangle(v.v, st[j].v, st[j + 1].v));
        st.pop_back();
    }

    return res;
}

ll getArea(vector<Vertex> vertices) {
    vertices.push_back(vertices[0]);
    ll area = 0;
    forn (i, (int) vertices.size() - 1)
        area += vertices[i].p % vertices[i + 1].p;
    return area;
}

namespace split {
    vector<Vertex> poly;
    vector<Point> polyp;
    vector<int> helper;
    vector<int> used;

    struct Edge
    {
        int from, to;
        int next;
        bool isBad;
    };
    vector<Edge> edges;
    vector<vector<int>> g;

    enum class VertexType
    {
        Start,
        End,
        Split,
        Merge,
        Regular,
    };

    bool isInside(Point p, Point p1, Point p2)
    {
        assert(p1.y > p2.y);
        return p2.y <= p.y && p.y <= p1.y;
    }

    bool isOnLeft(Point p, Point p1, Point p2)
    {
        assert(p1.y > p2.y);
        return (p2 - p1) % (p - p1) < 0;
    }

    int prevEdge(int v)
    {
        return v ? v - 1 : polyp.size() - 1;
    }

    int nextEdge(int v)
    {
        return v;
    }

    Point prevVert(int e)
    {
        return polyp[e];
    }

    Point nextVert(int e)
    {
        return e + 1 < polyp.size() ? polyp[e + 1] : polyp[0];
    }

    VertexType getType(int id) {
        auto const& v = poly[id].p;
        auto const& next = nextVert(nextEdge(id));
        auto const& prev = prevVert(prevEdge(id));

        auto product = (next - v) % (prev - v);

        auto below = [](Point const &p, Point const &q)
        {
            if (p.y != q.y)
                return p.y < q.y;
            return p.x > q.x;
        };

        auto above = [](Point const &p, Point const &q)
        {
            if (p.y != q.y)
                return p.y > q.y;
            return p.x < q.x;
        };

        if (below(next, v) && below(prev, v)) {
            if (product > 0)
                return VertexType::Start;
            else if (product < 0)
                return VertexType::Split;
            else
                assert(false);
        }
        else if (above(next, v) && above(prev, v)) {
            if (product > 0)
                return VertexType::End;
            else if (product < 0)
                return VertexType::Merge;
            else
                assert(false);
        }
        else
            return VertexType::Regular;
//        else {
//            if (product < 0) {
////                if (prev.y == v.y && v.y < next.y || prev.y > v.y && v.y == next.y)
////                    return VertexType::Regular;
////                else
//                if (v.y == max(prev.y, next.y))
//                    return VertexType::Split;
//                else if (v.y == min(prev.y, next.y))
//                    return VertexType::Merge;
//                else
//                    assert(false);
//            }
//            else {
//                if (v.y == max(prev.y, next.y))
//                    return VertexType::Start;
//                else if (v.y == min(prev.y, next.y))
//                    return VertexType::End;
//                else
//                    assert(false);
//            }
//        }
    }

    struct VertexWrapper
    {
        int v;
    };

    struct EdgeComparator {
        bool operator()(int e1, int e2) {
            auto pe1 = prevVert(e1);
            auto ne1 = nextVert(e1);
            auto pe2 = prevVert(e2);
            auto ne2 = nextVert(e2);

            if (isInside(pe1, pe2, ne2))
                return isOnLeft(pe1, pe2, ne2);
            else if (isInside(ne1, pe2, ne2))
                return isOnLeft(ne1, pe2, ne2);
            else if (isInside(pe2, pe1, ne1))
                return !isOnLeft(pe2, pe1, ne1);
            else if (isInside(ne2, pe1, ne1))
                return !isOnLeft(ne2, pe1, ne1);
            else {

                assert(false);
            }
//            return isOnLeft(prevVert(e1), prevVert(e2), nextVert(e2)) || isOnLeft(nextVert(e1), prevVert(e2), nextVert(e2));
        }

        bool operator()(int e, VertexWrapper v) const
        {
            return !isOnLeft(polyp[v.v], prevVert(e), nextVert(e));
        }

        using is_transparent = true_type;
    };

    set<int, EdgeComparator> status;

    void addEdge(int from, int to, bool isBad)
    {
        int num = edges.size();
        edges.push_back({from, to, -1, isBad});
        g[from].push_back(num);
    }

    void addEdge(int a, int b)
    {
        if ((a + 1) % polyp.size() == b || (b + 1) % polyp.size() == a)
            return;
//        cerr << endl << endl;
//        cerr << "!@#$ EDGE " << a << ' ' << b << endl;
//        cerr << endl << endl;
//        cerr << endl << endl;

        addEdge(a, b, false);
        addEdge(b, a, false);
    }

    int getId(Point p)
    {
        for (int i = 0; i < polyp.size(); i++)
            if (polyp[i] == p)
                return i;
        assert(false);
    }

    void printStatus()
    {
//        cerr << "STATUS: ";
//        for (int e : status) {
//            cerr << "(" << e << " : " << getId(prevVert(e)) << ", " << getId(nextVert(e)) << ")" << ' ';
//        }
//        cerr << endl;
    }

    void addToStatus(int e, int v)
    {
        if (prevVert(e).y == nextVert(e).y)
            return;
//        cerr << "for " << v  << " adding (" << getId(prevVert(e)) << ", " << getId(nextVert(e)) << ")" << endl;

        helper[e] = v;

//        cerr << "Before adding:";
//        printStatus();
        status.insert(e);
//        cerr << "After adding:";
//        printStatus();
    }

    void removeFromStatus(int e, int v)
    {
        if (prevVert(e).y == nextVert(e).y)
            return;
        if (getType(helper[e]) == VertexType::Merge)
            addEdge(v, helper[e]);

        status.erase(status.find(e));
    }

    int findLeftEdge(int v)
    {
        printStatus();

        auto iter = status.lower_bound(VertexWrapper{v});
        if (iter == status.begin())
            return -1;
//        assert(iter != status.end());
        assert(iter != status.begin());
        iter--;

//        cerr << "for " << v << " found " << *iter << endl;

        return *iter;
    }

    void updateHelper(int v, bool forceEdge=false)
    {
        int leftEdge = findLeftEdge(v);
        if (leftEdge == -1)
            return;
        if (forceEdge || getType(helper[leftEdge]) == VertexType::Merge)
            addEdge(v, helper[leftEdge]);
        helper[leftEdge] = v;
    }

    void handleStart(int v)
    {
        addToStatus(nextEdge(v), v);
    }

    void handleEnd(int v)
    {
        removeFromStatus(prevEdge(v), v);
    }

    void handleSplit(int v) {
        updateHelper(v, true);
        addToStatus(nextEdge(v), v);
    }

    void handleMerge(int v) {
        removeFromStatus(prevEdge(v), v);
        updateHelper(v);
    }

    void handleRegular(int v) {
        if (prevVert(prevEdge(v)).y > nextVert(nextEdge(v)).y) {
//            cerr << "!here" << endl;
            removeFromStatus(prevEdge(v), v);
            addToStatus(nextEdge(v), v);
        }
        else {
//            cerr << "@here" << endl;
            updateHelper(v);
//            cerr << "status after @here:" << endl;
//            printStatus();
        }
    }

    void dfs(int e, vector<Vertex>& vs)
    {
        used[e] = true;
        vs.push_back(poly[edges[e].from]);

        int next_e = edges[e ^ 1].next;
        if (!used[next_e])
            dfs(next_e, vs);
    }

    bool testYPoly(vector<Vertex> const& vs) {
        for (int i = 0; i < vs.size(); i++) {
            Point prev = i ? vs[i - 1].p : vs.back().p;
            Point next = i + 1 < vs.size() ? vs[i + 1].p : vs[0].p;
            Point curr = vs[i].p;

            auto product = (next - curr) % (prev - curr);

            if ((curr.y > next.y && curr.y > prev.y || curr.y < next.y && curr.y < prev.y) && product < 0) {
                cerr << endl << endl << endl << endl;
                cerr << "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" << endl;
                cerr << prev.x << ' ' << prev.y << " ; " << curr.x << ' ' << curr.y << " ; " << next.x << ' ' << next.y << endl;
                for (int i = 0; i < vs.size(); i++)
                    cerr << vs[i].p.x << ' ' << vs[i].p.y << " ; ";
                cerr << endl;

                return false;
            }
        }

        return true;
    }

    bool testSplit(vector<vector<Vertex>> const& split)
    {
        size_t totalTriangles = 0;
        for (auto vs : split) {
            if (!testYPoly(vs))
                return false;
            totalTriangles += vs.size() - 2;
        }

        cout << "all polys are y-monotonos" << endl;

        return totalTriangles == poly.size() - 2;
    }

    vector<vector<Vertex>> splitYPoly(vector<Vertex> _poly) {
        split::poly.clear();
        split::polyp.clear();
        split::helper.clear();
        split::used.clear();
        split::status.clear();
        split::edges.clear();
        split::g.clear();

        poly = _poly;
        g.resize(poly.size());

        /*ofstream output("c.out");
        output << poly.size() << endl;
        for (auto i = 0; i < poly.size(); i++)
            output << poly[i].p.x << ' ' << poly[i].p.y << endl;*/


        polyp.resize(poly.size());
        for (size_t i = 0; i < poly.size(); i++)
            polyp[i] = poly[i].p;

        helper.resize(_poly.size());

        vector<int> ids(poly.size());
        for (int i = 0; i < ids.size(); i++)
            ids[i] = i;

        sort(ids.begin(), ids.end(), [](int id1, int id2) {
            if (poly[id1].p.y != poly[id2].p.y)
                return poly[id1].p.y > poly[id2].p.y;
            return poly[id1].p.x < poly[id2].p.x;
//            return poly[id1].p.y > poly[id2].p.y || poly[id1].p.y == poly[id2].p.y && (id1 > id2 || id1 == 0 && id2 == polyp.size() - 1);
        });


//        for (auto id : ids)
//            cerr << id << ' ';
//        cerr << endl;

        for (auto id : ids) {
//            cerr << "processing " << id << endl;
            switch (getType(id)) {
                case VertexType::Start:
                    handleStart(id);
                    break;
                case VertexType::End:
                    handleEnd(id);
                    break;
                case VertexType::Split:
                    handleSplit(id);
                    break;
                case VertexType::Merge:
                    handleMerge(id);
                    break;
                case VertexType::Regular:
                    handleRegular(id);
                    break;
            }
        }

        for (int i = 0; i < polyp.size(); i++) {
            addEdge(i, (i + 1) % polyp.size(), false);
            addEdge((i + 1) % polyp.size(), i, true);
        }

        /*ofstream out("d.out");
        for (size_t i = 0; i < polyp.size(); i++)
            for (auto e : g[i])
                out << edges[e].from << ' ' << edges[e].to << endl;*/

        for (int i = 0; i < polyp.size(); i++) {
            sort(g[i].begin(), g[i].end(), [](int e1, int e2) {
                return (polyp[edges[e1].to] - polyp[edges[e1].from]).angle() < (polyp[edges[e2].to] - polyp[edges[e2].from]).angle();
            });

            for (size_t j = 1; j < g[i].size(); j++)
                edges[g[i][j]].next = g[i][j - 1];
            edges[g[i][0]].next = g[i].back();
        }

        used.resize(edges.size());
        vector<vector<Vertex>> result;
        for (int i = 0; i < edges.size(); i++)
            if (!used[i] && !edges[i].isBad) {
                vector<Vertex> current;
                dfs(i, current);
                result.push_back(current);
            }

        /*ofstream out2("b.out");
        out2 << result.size() << endl;
        for (auto vs : result) {
            out2 << vs.size() << endl;
            for (auto v : vs)
                out2 << v.p.x << ' ' << v.p.y << endl;
        }*/

//        assert(testSplit(result));

        return result;
    }
}


void printTriangulation(Triangulation trl) {
    std::cerr << "Segments: \n";

    for (Segment seg : trl.edges) {
        std::cerr << seg.v1.id << " " << seg.v2.id << "\n";
    }

    std::cerr << "Triangulation: \n";

    for (Triangle tr : trl.triangles) {
        std::cerr << tr.v1.id << " " << tr.v2.id <<" " << tr.v3.id << "\n";
    }
}

Triangulation getTriangulation(vector<Vertex> poly) {
    /*std::cerr << "Poly \n";
    for (int i = 0; i < (int)poly.size(); ++i) {
        std::cerr << poly[i].id << ": " << poly[i].p.x << " , " << poly[i].p.y << "\n";
    }
    std::cerr << "\n\n";*/

    vector<Segment> poly_edges;
    for (int i = 0; i < poly.size(); ++i) {
        poly_edges.push_back(Segment(poly[i], poly[(i + 1) % poly.size()]));
    }

    vector<vector<Vertex>> poles = split::splitYPoly(poly);

    /*for (int i = 0; i < (int)poles.size(); ++i) {
        std::cerr<<"poly 1: ";
        for (int j = 0; j < (int)poles[i].size(); ++j) {
            std::cerr << poles[i][j].id << " ";
        }
        std::cerr << "\n";
    }*/

    Triangulation res;

    for (int i = 0; i < (int)poles.size(); ++i) {
        Triangulation tr = triangulationYpoly(poles[i]);

        //printTriangulation(tr);

        res.merge(tr);
    }

    sort(res.edges.begin(), res.edges.end());
    res.edges.resize(unique(res.edges.begin(), res.edges.end()) - res.edges.begin());
    sort(poly_edges.begin(), poly_edges.end());

    int pos = 0;
    int j = 0;
    for (int i = 0; i < res.edges.size();) {
        if (j == poly_edges.size() || res.edges[i] < poly_edges[j]) {
            res.edges[pos] = res.edges[i];
            ++i;
            ++pos;
        } else if (i == res.edges.size() || poly_edges[j] < res.edges[i]) {
            ++j;
        } else {
            ++i;
        }
    }

    res.edges.resize(pos);

    //printTriangulation(res);

    return res;
}

void testTriangleYmonot() {
    int n;
    scanf("%d", &n);
    vector<Vertex> poly(n);
    for (int i = 0; i < n; ++i) {
        poly[i].p.read();
        poly[i].id = i;
    }

    Triangulation trl = triangulationYpoly(poly);
    sort(trl.edges.begin(), trl.edges.end());
    trl.edges.resize(unique(trl.edges.begin(), trl.edges.end()) - trl.edges.begin());

    printf("Segments: \n");

    for (Segment seg : trl.edges) {
        printf("%d  %d\n", seg.v1.id, seg.v2.id);
    }

    printf("Triangulation: \n");

    for (Triangle tr : trl.triangles) {
        printf("%d %d %d\n", tr.v1.id, tr.v2.id, tr.v3.id);
    }
}

void testTriangle() {
    int n;
    scanf("%d", &n);
    vector<Vertex> poly(n);
    for (int i = 0; i < n; ++i) {
        poly[i].p.read();
        poly[i].id = i;
    }

    Triangulation trl = getTriangulation(poly);

    printf("Segments: \n");

    for (Segment seg : trl.edges) {
        printf("%d  %d\n", seg.v1.id, seg.v2.id);
    }

    printf("Triangulation: \n");

    for (Triangle tr : trl.triangles) {
        printf("%d %d %d\n", tr.v1.id, tr.v2.id, tr.v3.id);
    }
}


inline bool areSegmentsIntersected(int a, int b, int c, int d) {
    if (a > b)
        swap(a, b);
    if (c > d)
        swap (c, d);
    return max(a, c) <= min(b, d);
}

bool hasDifferentSigns(ll a, ll b) {
    return a == 0 || b == 0 || (a > 0 && b < 0) || (a < 0 && b > 0);
}

inline bool areSegmentsIntersected(const Segment &segment1, const Segment &segment2) {
    Vertex a = segment1.v1, b = segment1.v2, c = segment2.v1, d = segment2.v2;
    return areSegmentsIntersected(a.p.x, b.p.x, c.p.x, d.p.x)
           && areSegmentsIntersected(a.p.y, b.p.y, c.p.y, d.p.y)
           && hasDifferentSigns(Triangle(a, b, c).getArea(), Triangle(a, b, d).getArea())
           && hasDifferentSigns(Triangle(c, d, a).getArea(), Triangle(c, d, b).getArea());
}

bool areTriangleIntersected(const Triangle &t1, const Triangle &t2) {
    auto vertices1 = t1.getVertices();
    auto vertices2 = t2.getVertices();
    for (auto &v : vertices1)
        if (t2.containsPoint(v))
            return true;
    for (auto &v : vertices2)
        if (t1.containsPoint(v))
            return true;
    auto segments1 = t1.getSegments();
    auto segments2 = t2.getSegments();
    for (auto &segment1: segments1)
        for (auto &segment2: segments2)
            if (areSegmentsIntersected(segment1, segment2))
                return true;
    return false;
}

bool angleComparator(const Vertex &v1, const Vertex &v2) {
    return v1.p.angle() < v2.p.angle();
}

void divide(const vector<Vertex> &vertices, const Triangulation &triangulation,
            vector<Triangle> &triangles, map<Triangle, int> &triangleIds, vector<vector<int>> &graph) {
    /*
    puts("Vertices:");
	for (auto &vertex: vertices) {
	 	printf("%d %d\n", vertex.p.x, vertex.p.y);
	}
	puts("Edges:");
	for (auto &edge: triangulation.edges) {
	 	printf("(%d, %d) -- (%d, %d)\n", edge.v1.p.x, edge.v1.p.y, edge.v2.p.x, edge.v2.p.y);
	}
	puts("Triangles:");
	for (auto &triangle: triangulation.triangles) {
	 	printf("(%d, %d) -- (%d, %d) -- (%d, %d)\n", triangle.v1.p.x, triangle.v1.p.y, triangle.v2.p.x, triangle.v2.p.y, triangle.v3.p.x, triangle.v3.p.y);
	}
	*/

    if (vertices.size() == 4) {
        graph.push_back({triangleIds[triangulation.triangles[0]], triangleIds[triangulation.triangles[1]]});
        return;
    }
    map<Vertex, vector<Vertex>> edges;
    map<Vertex, Triangulation> newTriangulation;
    for (auto &edge: triangulation.edges) {
        edges[edge.v1].push_back(edge.v2);
        edges[edge.v2].push_back(edge.v1);
    }
    Triangulation nextTriangulation;
    set<Vertex> forbiddenVertices, verticesToDelete;
    forn (i, (int) vertices.size() - 4) { //last 4 vertices can't be deleted
        if (edges[vertices[i]].size() <= MAX_DEGREE && !forbiddenVertices.count(vertices[i])) {
            verticesToDelete.insert(vertices[i]);
            vector<Vertex> neighbours;
            for (auto &vertex: edges[vertices[i]]) {
                forbiddenVertices.insert(vertex);
                neighbours.push_back(Vertex(vertex.p - vertices[i].p, vertex.id));
            }
            sort(neighbours.begin(), neighbours.end(), angleComparator);
            for (auto &vertex: neighbours) {
                vertex.p += vertices[i].p;
            }
            Triangulation partTriangulation = getTriangulation(neighbours);
            for (auto &newTriangle : partTriangulation.triangles) {
                triangleIds[newTriangle] = triangles.size();
                triangles.push_back(newTriangle);
                graph.push_back({});
            }
            newTriangulation[vertices[i]] = partTriangulation;
            nextTriangulation.merge(partTriangulation);
        }
    }
    for (auto &edge : triangulation.edges)
        if (!verticesToDelete.count(edge.v1) && !verticesToDelete.count(edge.v2))
            nextTriangulation.edges.push_back(edge);
    for (auto &triangle : triangulation.triangles) {
        auto triangleVertices = triangle.getVertices();
        bool wasDeleted = 0;
        for (auto &vertex: triangleVertices)
            if (verticesToDelete.count(vertex)) {
                wasDeleted = 1;
                Triangulation partTriangulation = newTriangulation[vertex];
                for (auto newTriangle : partTriangulation.triangles) {
                    if (areTriangleIntersected(triangle, newTriangle)) {
                        graph[triangleIds[newTriangle]].push_back(triangleIds[triangle]);
                    }
                }
            }
        if (!wasDeleted)
            nextTriangulation.triangles.push_back(triangle);
    }
    vector<Vertex> nextVertices;
    for (auto &vertex: vertices)
        if (!verticesToDelete.count(vertex))
            nextVertices.push_back(vertex);
    divide(nextVertices, nextTriangulation, triangles, triangleIds, graph);
}

Triangulation getSubTriangulation(const vector<Vertex> &vertices, int lInd, int rInd, Vertex v) {
    if (lInd == rInd)
        return Triangulation();
    vector<Vertex> subVector;
    if (rInd > lInd)
        subVector = vector<Vertex>(vertices.begin() + lInd, vertices.begin() + rInd + 1);
    else {
        subVector = vector<Vertex>(vertices.begin() + lInd, vertices.end());
        forn (i, rInd + 1)
            subVector.push_back(vertices[i]);
    }
    reverse(subVector.begin(), subVector.end());
    subVector.push_back(v);
    return getTriangulation(subVector);
}

TriangulationDetalization buildTriangulationDetalization(vector<Vertex> vertices) { //vertices should be in counter clockwise order
    if (getArea(vertices) < 0) {
        reverse(vertices.begin(), vertices.end());
    }
    Vertex topRight    = Vertex(Point(MAX + 1,    MAX + 1),    vertices.size());
    Vertex topLeft     = Vertex(Point(-(MAX + 1), MAX + 1),    vertices.size() + 1);
    Vertex bottomRight = Vertex(Point(MAX + 1,    -(MAX + 1)), vertices.size() + 2);
    Vertex bottomLeft  = Vertex(Point(-(MAX + 1), -(MAX + 1)), vertices.size() + 3);
    auto triangulation = getTriangulation(vertices);
    int insideIdThreshold = triangulation.triangles.size();
    int minX = MAX + 1, maxX = -(MAX + 1), minY = MAX + 1, maxY = -(MAX + 1);
    int maxXInd = -1, minXInd = -1, maxYInd = -1, minYInd = -1;
    forn (i, (int) vertices.size()) {
        if (vertices[i].p.x > maxX) {
            maxX = vertices[i].p.x;
            maxXInd = i;
        }
        if (vertices[i].p.x < minX) {
            minX = vertices[i].p.x;
            minXInd = i;
        }
        if (vertices[i].p.y > maxY) {
            maxY = vertices[i].p.y;
            maxYInd = i;
        }
        if (vertices[i].p.y < minY) {
            minY = vertices[i].p.y;
            minYInd = i;
        }
    }
    Triangle triangleR(bottomRight, topRight, vertices[maxXInd]);
    Triangle triangleU(topRight, topLeft, vertices[maxYInd]);
    Triangle triangleL(topLeft, bottomLeft, vertices[minXInd]);
    Triangle triangleD(bottomLeft, bottomRight, vertices[minYInd]);
    for (auto &triangle : {triangleR, triangleU, triangleL, triangleD})
        triangulation.merge(Triangulation({triangle.getSegments()}, {triangle}));
    triangulation.merge(getSubTriangulation(vertices, maxXInd, maxYInd, topRight));
    triangulation.merge(getSubTriangulation(vertices, maxYInd, minXInd, topLeft));
    triangulation.merge(getSubTriangulation(vertices, minXInd, minYInd, bottomLeft));
    triangulation.merge(getSubTriangulation(vertices, minYInd, maxXInd, bottomRight));
    forn (i, (int) vertices.size()) {
        int nextIndex = (i == (int) vertices.size() - 1) ? 0 : i + 1;
        triangulation.edges.push_back(Segment(vertices[i], vertices[nextIndex]));
    }
    sort(triangulation.edges.begin(), triangulation.edges.end());
    triangulation.edges.resize(
            unique(triangulation.edges.begin(), triangulation.edges.end()) - triangulation.edges.begin());
    for (auto &vertex : {topRight, topLeft, bottomRight, bottomLeft})
        vertices.push_back(vertex);
    vector<vector<int>> graph;
    map<Triangle, int> triangleIds;
    vector<Triangle> triangles;
    for (auto triangle : triangulation.triangles) {
        triangleIds[triangle] = triangles.size();
        triangles.push_back(triangle);
        graph.push_back({});
    }
    divide(vertices, triangulation, triangles, triangleIds, graph);
    return TriangulationDetalization(triangles, graph, insideIdThreshold);
}


int main(int argc, char **argv) {
//#ifdef LOCAL
    freopen(argv[1], "r", stdin);
    freopen("a.out", "w", stdout);
//#endif

    int testNumber;
    scanf("%d", &testNumber);
    forn (test, testNumber) {
        std::cerr << "test num = " << test << endl;
        int n;
        scanf("%d", &n);
        vector<Vertex> vertices;
        set<Point> verticesSet;
        forn (i, n) {
            Point p;
            p.read();
            //std::cerr << p.x << " " << p.y << "\n";
            vertices.push_back(Vertex(p, i));
            verticesSet.insert(p);
        }

        assert((int) verticesSet.size() == n);
        auto triangulationDetalization = buildTriangulationDetalization(vertices);
        int queries;
        scanf("%d", &queries);
        forn (q, queries) {
            Point p;
            p.read();
            //p.write();
            puts(triangulationDetalization.isPointInside(p) ? "INSIDE" : "OUTSIDE");
        }
    }

    return 0;
}