#include <iostream>
#include <vector>
#include <unordered_map>
#include <fstream>
#include <sstream>
#include <functional>
#include <queue>
#include <list>
#include <algorithm>
#include <set>
#include <map>
#include <thread>
#include <mutex>
#include "blimit.h"

#ifndef NDEBUG
const bool DEBUG = false;
#else
const bool DEBUG = true;
#endif

using pair_uu = std::pair<unsigned, unsigned>;
using vector_puu = std::vector<pair_uu>;
using ud_graph = std::map<unsigned, vector_puu, std::greater<>>;
using u_queue = std::queue<unsigned, std::list<unsigned>>;
using set_puu_desc = std::set<pair_uu, std::greater<>>;
using set_puu_inc = std::set<pair_uu>;
using map_of_sets_desc = std::unordered_map<unsigned, set_puu_desc>;
using map_of_sets_inc = std::unordered_map<unsigned, std::set<pair_uu>>;


static void output(const std::string &s) {
    if (DEBUG)
        std::cout << s << std::endl;
}

static void print_graph(const ud_graph &graph) {
    for (const auto &vertex : graph) {
        for (const auto &edge : vertex.second) {
            std::cout << vertex.first << " " << edge.first << " " << edge.second << std::endl;
        }
    }
}

static void print_info(map_of_sets_desc& S, map_of_sets_desc& N_T, map_of_sets_desc &T, unsigned u, unsigned x) {
    output("zawartosc S w wierzcholku " + std::to_string(x));
    for (auto & pary : S.at(x)) {
        output(std::to_string(pary.first) + ", " + std::to_string(pary.second));
    }

    output("zawartosc N_T w wierzcholku " + std::to_string(u));
    for (auto & pary : N_T.at(u)) {
        output(std::to_string(pary.first) + ", " + std::to_string(pary.second));
    }
    output("zawartosc T w wierzcholku " + std::to_string(u));
    for (auto & pary : T.at(u)) {
        output(std::to_string(pary.first) + ", " + std::to_string(pary.second));
    }
}

static void create_info(const ud_graph& graph, map_of_sets_desc& T,
                        map_of_sets_desc& N, map_of_sets_desc &S,
                        map_of_sets_desc& N_T, u_queue& Q) {
    for (const auto &vertex : graph) {
        S.insert(std::make_pair(vertex.first, set_puu_desc()));
        T.insert(std::make_pair(vertex.first, set_puu_desc()));
        N_T.insert(std::make_pair(vertex.first, set_puu_desc()));
        N.insert(std::make_pair(vertex.first, set_puu_desc()));
        Q.push(vertex.first);
        for (const auto &edge : vertex.second) {
            N_T.at(vertex.first).insert(std::make_pair(edge.second, edge.first));
            N.at(vertex.first).insert((std::make_pair(edge.second, edge.first)));
        }
    }
}

pair_uu search_to_suite(const map_of_sets_desc& N_T,
                        const map_of_sets_desc& S, unsigned b_u, unsigned u) {
    for (const auto &ntq : N_T.at(u)) {
        const auto& s_last = S.at(ntq.second).rbegin();
        auto &s_x = S.at(ntq.second);
        output("x = " + std::to_string(ntq.first) + ", " + std::to_string(ntq.second));
        if (bvalue(b_u, ntq.second) == 0)
            continue;
        if (s_x.size() < bvalue(b_u, ntq.second) || !((ntq.first < s_last->first) ||
                                                                   (ntq.first == s_last->first &&
                                                                    u < s_last->second))) {
            output("jest ok");
            return std::make_pair(ntq.first, ntq.second);
        } else {
            output("nie nadaje sie - nastepny");
            continue;
        }
    }
    return {0, 0};
}

static void remove_worse_adorer(set_puu_desc& s_x, map_of_sets_desc& T, u_queue& R, pair_uu& x) {
    pair_uu y;
    output("wierzcholek nr " + std::to_string(x.second) + " ma b(v) adoratorow");
    auto it = s_x.rbegin();
    y = std::make_pair(it->first, it->second);
    s_x.erase(*it);
    output("usuwa " + std::to_string(y.first) + ", " + std::to_string(y.second) + " z " + std::to_string(x.second));
    T[y.second].erase({y.first, x.second});
    //N_T[y.second].insert({y.first, x.second});
    R.push(y.second);
    output("do kolejki R wrzucono " + std::to_string(y.second));
}

static void insert_adorer(set_puu_desc& s_x, map_of_sets_desc& N_T, map_of_sets_desc& T, pair_uu x,
                          unsigned u) {
    s_x.insert(std::make_pair(x.first, u));
    N_T.at(u).erase(x);
    T.at(u).insert(x);
}

unsigned count_edges(map_of_sets_desc& S) {
    unsigned result{0};
    for (auto & p : S) {
        output("wierzcholek nr " + std::to_string(p.first));
        for (auto &pair : p.second) {
            output(std::to_string(pair.first) + ", " + std::to_string(pair.second));
            auto &s_x = S.at(pair.second);
            if (s_x.count({pair.first, p.first})) {
                output("znaleziono odpowiednik");
                result += pair.first;
                s_x.erase({pair.first, p.first});
            }
        }
    }
    return result;
}

// first - waga, second - numer wierzcholka
unsigned adorate_sequential(const ud_graph &graph, unsigned b_u) {
    u_queue Q, R;
    map_of_sets_desc S, N_T;
    map_of_sets_desc T, N;
    pair_uu x;

    create_info(graph, T, N, S, N_T, Q);

    while (!Q.empty()) {
        unsigned long qsize = Q.size();
        for (unsigned long i = qsize; i > 0; --i) {
            unsigned u = Q.front();
            Q.pop();
            output("wierzcholek nr " + std::to_string(u));
            while (T[u].size() < bvalue(b_u, u)) {
                if (N_T.at(u).empty()) {
                    output("brak sasiadow");
                    break;
                }
                x = search_to_suite(N_T, S, b_u, u);

                output("Czy udalo sie wybrac sasiada?");
                if (x.first == 0) {
                    output("brak dobrego sasiada");
                    break;
                }
                output("wybrano sasiada: " + std::to_string(x.first) + ", " + std::to_string(x.second));

                output("Sprawdzam b(x)");
                auto & s_x = S.at(x.second);
                if (s_x.size() == bvalue(b_u, x.second)) {
                    remove_worse_adorer(s_x, T, R, x);
                }
                insert_adorer(s_x, N_T, T, x, u);
                print_info(S, N_T, T, u, x.second);
            }
        }
        Q = R;
        R = u_queue();
    }
    return count_edges(S);
}

static void write_info(std::vector<u_queue>& Q, map_of_sets_desc& S,
                       map_of_sets_desc& N_T,
                       map_of_sets_desc& T,
                       map_of_sets_desc& N,
                       std::unordered_map<unsigned, unsigned>& B,
                       std::unordered_map<unsigned, unsigned>& C,
                       std::unordered_map<unsigned, unsigned>& D,
                       std::unordered_map<unsigned, std::unique_ptr<std::mutex>>& S_mutex,
                       std::unordered_map<unsigned, std::unique_ptr<std::mutex>>& T_mutex,
                       const ud_graph& graph,
                       unsigned thread_num, unsigned b_u) {
    for (unsigned i = 0; i < thread_num; ++i) {
        Q.emplace_back(u_queue());
    }

    unsigned count{0};
    for (const auto &vertex : graph) {
        B.insert(std::make_pair(vertex.first, bvalue(b_u, vertex.first)));
        C.insert(std::make_pair(vertex.first, 1));
        D.insert(std::make_pair(vertex.first, 0));
        S.insert(std::make_pair(vertex.first, set_puu_desc()));
        T.insert(std::make_pair(vertex.first, set_puu_desc()));
        S_mutex.insert(std::make_pair(vertex.first, std::make_unique<std::mutex>()));
        T_mutex.insert(std::make_pair(vertex.first, std::make_unique<std::mutex>()));
        N_T.insert(std::make_pair(vertex.first, set_puu_desc()));
        N.insert(std::make_pair(vertex.first, set_puu_desc()));
        Q[count % thread_num].push(vertex.first);
        for (const auto &edge : vertex.second) {
            N_T.at(vertex.first).insert(std::make_pair(edge.second, edge.first));
            N.at(vertex.first).insert((std::make_pair(edge.second, edge.first)));
        }
        count++;
    }
}

void adorate_parallel(u_queue& Q,
                      map_of_sets_desc& S,
                      map_of_sets_desc& N_T,
                      map_of_sets_desc& T,
                      map_of_sets_desc& N,
                      std::unordered_map<unsigned, unsigned>& B,
                      std::unordered_map<unsigned, unsigned>& C,
                      std::unordered_map<unsigned, unsigned>& D,
                      std::unordered_map<unsigned, std::unique_ptr<std::mutex>>& S_mutex,
                      std::unordered_map<unsigned, std::unique_ptr<std::mutex>>& T_mutex,
                      std::mutex& mutex, unsigned id, unsigned method) {
    u_queue R;
    pair_uu x;

    while (!Q.empty()) {
        unsigned long qsize = Q.size();
        for (unsigned long i = qsize; i > 0; --i) {
            unsigned u = Q.front();
            Q.pop();
            std::lock_guard<std::mutex> lgu(*T_mutex[u]);
            output("wierzcholek nr " + std::to_string(u));
            while (T[u].size() < B[u]) {
                x = {0, 0};
                for (const auto &ntq : N.at(u)) {

                    std::lock_guard<std::mutex> tm(*S_mutex[ntq.second]);
                    if (B[ntq.second] == 0 || S[ntq.second].count({ntq.first, u})) {
                        continue;
                    }
                    const auto& s_last = S.at(ntq.second).rbegin();
                    auto &s_x = S.at(ntq.second);
                    output("x = " + std::to_string(ntq.first) + ", " + std::to_string(ntq.second));
                    if (s_x.size() < B[ntq.second] || !((ntq.first < s_last->first) ||
                            (ntq.first == s_last->first && u < s_last->second))) {
                        output("jest ok");
                        x = std::make_pair(ntq.first, ntq.second);
                        break;
                    } else {
                        output("nie nadaje sie - nastepny");
                        continue;
                    }
                }
                output("Czy udalo sie wybrac sasiada?");
                if (x.first == 0) {
                    output("brak dobrego sasiada");
                    break;
                }
                std::lock_guard<std::mutex> lgm(*S_mutex[x.second]);
                if (S[x.second].count({x.first, u}))
                    continue;

                auto & s_x = S.at(x.second);
                const auto& s_last = s_x.rbegin();
                output("czy x wciaz jest najlepszy?");
                if (T.at(u).count({x.first, x.second})  && (x.first < s_last->first ||
                                                  (x.first == s_last->first && u < s_last->second))) {
                    output("sasiad juz nie jest najlepszy: " + std::to_string(x.first) + ", " + std::to_string(x.second));
                  //  R.push(u); // czy potrzebne?
                    continue; // albo break? chyba nie
                }
                output("wybrano sasiada: " + std::to_string(x.first) + ", " + std::to_string(x.second));

                output("Sprawdzam b(x)");
            //    {
            //        std::lock_guard<std::mutex> lgu(*T_mutex[u]);
             //       C[u]++;
           //     }
                if (s_x.size() == bvalue(method, x.second)) {
                    pair_uu y(*s_last);
                    s_x.erase(*s_last);
                    std::lock_guard<std::mutex> lgx(*T_mutex[y.second]);
                    C[y.second]--;
                    D[y.second]++;
                    T[y.second].erase({y.first, x.second});
                    R.push(y.second);
                }
                s_x.insert(std::make_pair(x.first, u));
                T.at(u).insert(x);
            }
        }
     //   u_queue P{R};
      //  while (!P.empty()) {
      //      unsigned v = P.front();
     //       P.pop();
     //       B[v] = D[v];
     //   }
        Q = R;
        R = u_queue();
    }
}

unsigned b_suitor_parallel(ud_graph &graph, unsigned thread_num, unsigned b_u) {
    std::vector<std::thread> threads;
    std::vector<u_queue> Q;
    map_of_sets_desc S, N_T;
    map_of_sets_desc T, N;
    std::unordered_map<unsigned, unsigned> B, C, D;
    std::unordered_map<unsigned, std::unique_ptr<std::mutex>> S_mutex;
    std::unordered_map<unsigned, std::unique_ptr<std::mutex>> T_mutex;
    write_info(Q, S, N_T, T, N, B, C, D, S_mutex, T_mutex, graph, thread_num, b_u);
    std::mutex mutex;
    for (unsigned i = 0; i < thread_num; ++i) {
        threads.emplace_back(adorate_parallel, std::ref(Q[i]), std::ref(S), std::ref(N_T),
                             std::ref(T), std::ref(N), std::ref(B), std::ref(C), std::ref(D), std::ref(S_mutex), std::ref(T_mutex), std::ref(mutex), i+1, b_u);
    }

    for (std::thread &t: threads) {
        t.join();
    }

    return count_edges(S);
}

void read_input(ud_graph &graph, const std::string &file_name) {
    std::ifstream data;
    std::string s;
    unsigned node1, node2, vague;

    data.open(file_name);
    if (data.is_open()) {
        while (getline(data, s)) {
            if (s.front() == '#')
                continue;

            std::stringstream SS(s);
            SS >> node1; SS >> node2; SS >> vague;

            graph.insert(std::make_pair(node1, std::vector<std::pair<unsigned, unsigned>>()));
            graph.insert(std::make_pair(node2, std::vector<std::pair<unsigned, unsigned>>()));
            graph[node1].emplace_back(std::make_pair(node2, vague));
            graph[node2].emplace_back(std::make_pair(node1, vague));
        }
    }
}

void check_correctness() {

    std::ifstream wzorce, wyniki;
    std::string swynik, swzorzec;
    wzorce.open("../data/wzorce.txt");
    wyniki.open("../data/wyniki.txt");
    bool ok = true;
    while (getline(wzorce, swzorzec) && getline(wyniki, swynik)) {
        if (swynik != swzorzec) {
            ok = false;
            break;
        }
        std::cout << "OK" << std::endl;
    }
    if (ok)
        std::cout << "OK_FINAL" << std::endl;
    else
        std::cout << "ZLY WYNIK" << std::endl;

}

int main(int argc, const char * argv[]) {
    if (argc != 4)
        std::exit(1);
    unsigned thread_number = (unsigned) std::stoi(argv[1]);
    std::string file_name = argv[2];
    unsigned b_limit =  (unsigned) std::stoul(argv[3]);
    ud_graph graph;
    read_input(graph, file_name);
    output("ZROBIONY GRAF");

    std::set<std::pair<unsigned, unsigned>> sett;

    std::ofstream outfile ("../data/wyniki.txt", std::ofstream::trunc);

    for (unsigned b_method = 0; b_method < b_limit + 1; b_method++) {
        std::cout << b_method << std::endl;
        outfile << b_suitor_parallel(graph, thread_number, b_method) << std::endl;
     //   outfile << adorate_sequential(graph, b_method) << std::endl;
    }

    outfile.close();

    check_correctness();

    std::set<unsigned> k;
    std::cout << k.max_size() << std::endl;

    return 0;
}