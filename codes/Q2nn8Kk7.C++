 
 
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58
59
60
61
62
63
64
65
66
67
68
69
70
71
72
73
74
75
76
77
78
79
80
81
82
83
84
85
86
87
88
89
90
91
92
93
94
95
96
97
98
99
100
101
102
103
104
105
106
107
108
109
110
111
112
113
114
115
116
117
118
119
120
121
122
123
124
125
126
127
128
129
130
131
132
133
134
135
136
137
138
139
140
141
142
143
144
145
146
147
148
149
150
151
152
153
154
155
156
157
158
159
160
161
162
163
164
165
166
167
168
169
170
171
172
173
174
175
176
177
178
179
180
181
182
183
184
185
186
187
188
189
190
191
192
193
194
195
196
 
 
 
 
#include <iostream>
#include <tuple>
#include <map>
 
namespace Wrapper {
    template<int i, class... Q>
    struct Comparator {
        static bool less_than(const std::tuple<Q...>& a, const std::tuple<Q...>& b) {
            if(std::get<i>(a) < std::get<i>(b))
                return Comparator<i - 1, Q...>::less_than(a, b);
            return false;
        }
    };
 
    template<class... Q>
    struct Comparator<-1, Q...> {
        static bool less_than(const std::tuple<Q...>& a, const std::tuple<Q...>& b) {
            return true;
        }
    };
}
 
template<class... Q>
struct Less {
    bool operator()(const std::tuple<Q...>& a, const std::tuple<Q...>& b) const {
        return Wrapper::Comparator<
            std::tuple_size<std::tuple<Q...>>::value - 1, Q...>::less_than(a, b);
    }
};
 
template<class ValueType, class... KeyType>
struct GenericLookupTable {
    std::map<std::tuple<KeyType...>, ValueType, Less<KeyType...>> map;
 
    bool contains(KeyType... key) const {
        std::tuple<KeyType...> tuple(key...);
        return map.find(tuple) != map.end();
    }
 
    ValueType& get(KeyType... key) {
        std::tuple<KeyType...> tuple(key...);
        return map.find(tuple)->second;
    }
 
    void insert(const ValueType& value, KeyType... key) {
        map.insert(std::pair<std::tuple<KeyType...>, ValueType>
            (std::tuple<KeyType...>(key...), value));
    }
};
 
template<long _Min, long _Max>
struct Range {
    enum {
        Min = _Min,
        Max = _Max
    };
    static_assert(_Min < _Max, "");
 
    static constexpr long values() {
        return _Max - _Min;
    }
};
 
namespace Wrapper {
    template<int n, class Range, class... Q>
    struct TotalArea {
        enum {
            value = Range::values() * TotalArea<n - 1, Q...>::value
        };
    };
 
    template<class Range, class... Q>
    struct TotalArea<0, Range, Q...> {
        enum { value = Range::values() };
    };
};
 
template<class ValueType, class... Ranges>
struct Array {
 
    static constexpr int dimension() {
        return sizeof...(Ranges);
    }
 
    static constexpr long size() {
        return (long) Wrapper::TotalArea<dimension() - 1, Ranges...>::value;
    }
 
    ValueType array[size()];
 
    template<int i>
    long get_index(long cum, long * indexes) {
        return 0;
    }
 
    template<int i, class R, class... Rs>
    long get_index(long cum, long * indexes) {
        return (indexes[i] - R::Min) * cum +
            get_index<i + 1, Rs...>(cum * R::values(), indexes);
    }
 
    template<class... Indexes>
    ValueType& get(Indexes... indexes) {
        long ids[dimension()] = { indexes... };
        return array[get_index<0, Ranges...>(1, ids)];
    }
 
    template<class... Indexes>
    void insert(const ValueType& value, Indexes... indexes) {
        get(indexes...) = value;
    }
};
 
template<class ValueType, class... Ranges>
struct LookupTable {
    struct Value {
        ValueType value;
        bool assigned;
        Value():
            assigned(false) {}
    };
 
    Array<Value, Ranges...> data;
 
    template<class... Indexes>
    bool contains(Indexes... indexes) {
        return data.get(indexes...).assigned;
    }
 
    template<class... Indexes>
    ValueType& get(Indexes... indexes) {
        return data.get(indexes...).value;
    }
 
    template<class... Indexes>
    void insert(const ValueType& value, Indexes... indexes) {
        Value& d = data.get(indexes...);
        d.value = value;
        d.assigned = true;
    }
};
 
template<unsigned int MaxCallStackHeight = 0>
struct DP {
 
    template<class Target, class Memory, class... Arg>
    struct Engine {
        Memory memory;
        Target target;
        int stack_height;
 
        Engine(const Memory& injected): memory(injected), stack_height(0) {}
        Engine(): Engine(Memory()) {}
 
        auto operator()(Arg... arg) -> decltype(target(*this, arg...)) {
            if(MaxCallStackHeight > 0) {
                stack_height++;
                if(stack_height > MaxCallStackHeight)
                    throw "Maximum stack height exceeded!";
            }
            if(memory.contains(arg...))
                return memory.get(arg...);
            decltype(target(*this, arg...)) result = target(*this, arg...);
            memory.insert(result, arg...);
            if(MaxCallStackHeight > 0)
                stack_height--;
            return result;
        }
    };
};
 
typedef DP<512000> DefaultDP;
 
struct NaiveFibonacci {
    template<class Recursion>
    unsigned long long operator()(Recursion& recurse, int n) {
        return n < 2? n:
            recurse(n - 1) + recurse(n - 2);
    }
};
 
int main() {
    try {
        DefaultDP::Engine<
            NaiveFibonacci,
            LookupTable<unsigned long long, Range<0, 1000>>,
            int> dp;
 
        for(int i = 0; i <= 1000; i++)
            std::cout << "fibonacci #" << i << ": " << dp(i) << "\n";
 
    } catch(const char * err) {
        std::cout << err << "\n";
    }
}