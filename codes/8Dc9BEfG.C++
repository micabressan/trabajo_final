#include <fstream>
#include <string>
#include <stdexcept>
#include <iterator>
#include <vector>
#include <cassert>
#include <iostream>

using namespace std;

const int L = 48;
const int R = 67;

const double FRACTION_DELETE = 2. / 5;

// '123435'...
int read_num(const string& str, int pos) {
    int num = 0;
    bool neg = false;
    if  (str[pos + 1] == '-') {
        neg = true;
        ++pos;
    }
    for (int i = pos + 1; str[i] != '\'' && i < str.size(); ++i) {
        assert('0' <= str[i] && str[i] <= '9');
        num = num * 10 + (str[i] - '0');
    }
    return neg ? -num : num;
}

void clear_num(string& str, int pos) {
    for (int i = pos; i < str.size(); ++i) {
        bool br = (str[i] == '\'') && (i > pos);
        str[i] = ' ';
        if  (br) {
            break;
        }
    }
}

inline int len_num(int num) {
    int len = 0;
    while (num) {
        ++len;
        num /= 10;
    }
    return len;
}

inline int cnt_spaces(const string& str, int pos) {
    int cnt = 0;
    for (int i = pos; i < str.size() && str[i] == ' '; ++i) {
        ++cnt;
    }
    return cnt;
}

void put_num(string& str, int pos, int num) {
    int len = len_num(num);
    int have_spaces = cnt_spaces(str, pos);
    assert(have_spaces > 0);
    if  (len + 2 + 1 > have_spaces) {
        str.insert(pos, string(len + 2 + 1 - have_spaces, ' '));
    }
    str[pos++] = '\'';
    int l = pos;
    while (num) {
        str[pos++] = (num % 10) + '0';
        num /= 10;
    }
    int r = pos - 1;
    reverse(str.begin() + l, str.begin() + r + 1);
    str[pos++] = '\'';
}

int main(int argc, char** argv) {
    assert(argc >= 2);
    string file_name(argv[1]);
    ifstream input_file(file_name);
    assert(input_file.is_open());

    string content;
    std::copy(std::istreambuf_iterator<char>(input_file), std::istreambuf_iterator<char>(), std::back_inserter(content));

    // points on in [L, R]
    vector<char> alive(content.size(), true);
    string pattern = "<part name=";
    for (int i = 0; i + pattern.size() - 1 < content.size(); ++i) {
        if  (content.substr(i, pattern.size()) == pattern) {
            int pos_num = i + pattern.size() + 1;
            int num = stoi(content.substr(pos_num, 2));
            if  (L <= num && num <= R) {
                int new_num = num - L;
                content[pos_num] = (new_num / 10) + '0';
                content[pos_num + 1] = (new_num % 10) + '0';
            } else {
                // go left
                for (int j = i; content[j] != '\n'; --j) {
                    alive[j] = false;
                }
                // go right
                for (int j = i; j < content.size(); ++j) {
                    alive[j] = false;
                    if  (content[j - 1] == '>') {
                        break;
                    }
                }
            }
        }
    }

    string res;
    for (int i = 0; i < content.size(); ++i) {
        if  (alive[i]) {
            res += content[i];
        }
    }
    content = res;

    // split face rect
    pattern = "<box";
    for (int i = 0; i + pattern.size() - 1 < content.size(); ++i) {
        if  (content.substr(i, pattern.size()) != pattern) {
            continue;
        }
        int top_num_pos = -1;
        for (int j = i; j < content.size(); ++j) {
            if  (content.substr(j, 5) == "top='") {
                top_num_pos = j + 3 + 1;
                break;
            }
        }
        assert(top_num_pos != -1);

        int height_num_pos = -1;
        for (int j = i; j < content.size(); ++j) {
            if  (content.substr(j, 8) == "height='") {
                height_num_pos = j + 6 + 1;
                break;
            }
        }

        int top = read_num(content, top_num_pos);
        int height = read_num(content, height_num_pos);

        top += height * FRACTION_DELETE;
        height = height * (1.0 - FRACTION_DELETE);

        clear_num(content, top_num_pos);
        put_num(content, top_num_pos, top);

        height_num_pos = -1;
        for (int j = i; j < content.size(); ++j) {
            if  (content.substr(j, 7) == "height=") {
                height_num_pos = j + 6 + 1;
                break;
            }
        }
        assert(height_num_pos != -1);

        clear_num(content, height_num_pos);
        put_num(content, height_num_pos, height);
    }

    string output_file_name(argv[2]);
    ofstream output_file(output_file_name);
    output_file << content;
    return 0;
}