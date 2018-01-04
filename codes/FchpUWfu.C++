#include <string>
#include <sstream>
#include <iostream>
#include <utility>
#include <iterator>
#include <map>
#include <memory>
#include <algorithm>
#include <set>
#include <vector>
#include <list>

using namespace std;

enum class type_t {
    _int, _uint, _char, _uchar, _double, _float
};

class buffer_t {
    char actual_buffer[20];
    size_t sizeof_buffer = 0;
    set<int> changed_bits;

    bool get_bit_value(int i) {
        struct {
            unsigned char* which_byte;
            int which_bit;
            bool value;
        } bit;

        bit.which_byte = reinterpret_cast<unsigned char*>(actual_buffer) + i / 8;
        bit.which_bit = 7 - i % 8;
        bit.value = *bit.which_byte >> 7 - bit.which_bit & 0x1;

        return bit.value;
    }

    void set_bit_value(int i, bool value) {
        struct {
            unsigned char* which_byte;
            int which_bit;
            bool value;
        } bit;

        bit.which_byte = reinterpret_cast<unsigned char*>(actual_buffer) + i / 8;
        bit.which_bit = 7 - i % 8;

        if (value)
            *bit.which_byte |= 1 << 7 - bit.which_bit;
        else
            *bit.which_byte &= ~(1 << 7 - bit.which_bit);
    }

public: 
    set<int> get_changed_info() {
        auto res = changed_bits;
        changed_bits.clear();
        return res;
    }

    void perform_shift(bool is_left, unsigned int amount) {
        if (sizeof_buffer == 0)
            throw runtime_error("input data first");
        amount %= sizeof_buffer * 8;
        //one move left
        vector<bool> bits;
        bits.resize(sizeof_buffer * 8);
        for (int i = 0; i < sizeof_buffer * 8; ++i)
            bits[i] = get_bit_value(i);
        vector<bool> old_values(bits);
        if (!is_left)
            rotate(bits.begin(), bits.begin() + amount, bits.end());
        else 
            rotate(bits.rbegin(), bits.rbegin() + amount, bits.rend());
        for (int i = 0; i < bits.size(); ++i)
            set_bit_value(i, bits[i]);
        //what bits should be painted
        for (int i = 0; i < bits.size(); ++i)
            if (bits[i] != old_values[i])
                changed_bits.emplace(i);
    }

    bool empty() const {
        return sizeof_buffer == 0;
    }

    void reset() {
        sizeof_buffer = 0;
    }

    template<class T>
    void set(T in) {
        *reinterpret_cast<T*>(actual_buffer) = in;
        sizeof_buffer = sizeof(T);
    }

    template <class T>
    T access() {
        if (sizeof(T) != sizeof_buffer) {
            reset();
            throw runtime_error("something went wrong");
        }
        return *reinterpret_cast<T*>(actual_buffer);
    }

    string binary_view() {
        string res;
        for (int i = sizeof_buffer - 1; i >= 0; --i) {
            uint8_t byte = actual_buffer[i];
            for (int bit = 7; bit >= 0; --bit)//7 == 8 - 1 == sizeof(byte) * 8 - 1
                res += '0' + static_cast<int>(byte >> bit & 0x1);
        }
        return res;
    }
};

namespace current_options {
    type_t type = type_t::_int;
    buffer_t buffer;
    int base = 10;
    int color = 2;
}

string to_string(unsigned long long in, int _base) {
    string res;
    do {
        res.insert(res.begin(), [&] {
            char next_symb = static_cast<char>(in % _base);
            in /= _base;
            return static_cast<char>((next_symb <= 10 ? '0' : 'A' - 10) + next_symb);//????
        }());
    } while (in > 0);
    return res;
}

string input_string() {
    string res;
    //while (res.empty())
        getline(cin, res);
    return res;
}

char input_char() {
    string res = input_string();
    if (res.size() != 1)
        throw runtime_error("wrong char input");
    return res.front();
}

map<type_t, string> type_map({
    make_pair(type_t::_int, "int"),
    make_pair(type_t::_uint, "unsigned int"),
    make_pair(type_t::_char, "char"),
    make_pair(type_t::_uchar, "unsigned char"),
    make_pair(type_t::_double, "double"),
    make_pair(type_t::_float, "float")
});

bool is_type_t_floating_point(type_t t) {
    return t == type_t::_double || t == type_t::_float;
}

string to_string(type_t t) {
    return type_map[t];
}

template <class T>
void parse_and_update_unsigned_ints(string in) {
    auto res = parse_like_ull(in, current_options::base);
    if (numeric_limits<T>::max() < res)
        throw runtime_error("number is too big");
    current_options::buffer.set<T>(res);
}

template <class T>
void parse_and_update_ints(string in) {
    bool negative = in.front() == '-';
    if (negative)
        in.erase(in.begin());
    auto res = parse_like_ull(in, current_options::base);
    if ((negative ? -1 * numeric_limits<T>::min() : numeric_limits<T>::max()) < res)
        throw runtime_error("number is too big");
    current_options::buffer.set<T>(negative ? -1 * res : res);
}

template <class T>
void parse_and_update_floats(string in) {
    T res;
    stringstream(in) >> res;
    current_options::buffer.set<T>(res);
}

bool custom_str_comparator(string s1, string s2) {
    if (s1.size() < s2.size())
        return true;//perfect case
    else if (s1.size() > s2.size())
        return false;
    for (auto it1 = s1.cbegin(), it2 = s2.cbegin(); it1 != s1.cend(); ++it1, ++it2)
        if (*it1 > *it2)
            return false;
        else if (*it1 < *it2)
            return true;
    return true;//equal
}

unsigned long long parse_like_ull(string in, int base) {
    if (!all_of(in.begin(), in.end(), [&](const char& c) {
        if (base <= 10)
            return '0' <= c && c <= '0' + (base - 1);
        return '0' <= c && c <= '9' || 'A' <= c && c <= 'A' + (base - 1 - 10);
    }))
        throw runtime_error("bad symbol");
    if (!custom_str_comparator(in, to_string(numeric_limits<unsigned long long>::max(), base)))
        throw runtime_error("bad input");
    return strtoull(in.c_str(), nullptr, base);
}

enum class option_t {
    type, value, base, shift, color, exit
};

string access_buffer_data() {
    switch (current_options::type) {
        case type_t::_int:
            return to_string(current_options::buffer.access<int>());
        case type_t::_uint:
            return to_string(current_options::buffer.access<unsigned int>());
        case type_t::_char:
            return to_string(current_options::buffer.access<char>());
        case type_t::_uchar:
            return to_string(current_options::buffer.access<unsigned char>());
        case type_t::_double:
            return to_string(current_options::buffer.access<double>());
        case type_t::_float:
            return to_string(current_options::buffer.access<float>());
        default:
            throw runtime_error("something went wrong");
    }
}

#include <Windows.h>

const map<string, int> color_map({
    make_pair("gray", FOREGROUND_INTENSITY),
    make_pair("blue", FOREGROUND_INTENSITY | FOREGROUND_BLUE),
    make_pair("green", FOREGROUND_INTENSITY | FOREGROUND_GREEN),
    make_pair("cyan", FOREGROUND_INTENSITY | FOREGROUND_GREEN | FOREGROUND_BLUE),
    make_pair("red", FOREGROUND_INTENSITY | FOREGROUND_RED),
    make_pair("magenta", FOREGROUND_INTENSITY | FOREGROUND_RED | FOREGROUND_BLUE),
    make_pair("yellow", FOREGROUND_INTENSITY | FOREGROUND_RED | FOREGROUND_GREEN),
    make_pair("white", FOREGROUND_INTENSITY | FOREGROUND_RED | FOREGROUND_GREEN | FOREGROUND_BLUE)
});

option_t get_option() {
    cout << "1 - type : " << to_string(current_options::type) << endl;
    cout << "2 - value : ";
    if (current_options::buffer.empty())
        cout << "no value yet" << endl;
    else {
        cout << endl << '\t' << "value : " << access_buffer_data() << endl
            << '\t' << "machine representation : ";
        string binary = current_options::buffer.binary_view();
        set<int> info_of_drawing = current_options::buffer.get_changed_info();
        //presets
        HANDLE hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
        CONSOLE_SCREEN_BUFFER_INFO consoleInfo;
        GetConsoleScreenBufferInfo(hConsole, &consoleInfo);
        WORD saved_attributes = consoleInfo.wAttributes;
        for (int i = 0; i < binary.size(); ++i) {

            if (i != 0 && i % 8 == 0)
                cout << ' ';

            if (info_of_drawing.find(binary.size() - i - 1) != info_of_drawing.end()) {
                SetConsoleTextAttribute(hConsole, current_options::color);
                cout << binary[i];
                SetConsoleTextAttribute(hConsole, saved_attributes);
            }
            else
                cout << binary[i];
        }
        cout << endl;
    }
    cout << "3 - input base : ";
    if (is_type_t_floating_point(current_options::type))
        cout << "not availiable" << endl;
    else 
        cout << current_options::base << endl;
    cout << "4 - perform shift" << endl;
    cout << "5 - change color" << endl;
    cout << "6 - exit" << endl;
    cout << "input an option : ";
    char input = input_char();
    if (input == '3' && is_type_t_floating_point(current_options::type))
        throw runtime_error("base option is not availiable for floating point types");
    if (input == '1')
        return option_t::type;
    if (input == '2')
        return option_t::value;
    if (input == '3')
        return option_t::base;
    if (input == '4')
        return option_t::shift;
    if (input == '5')
        return option_t::color;
    if (input == '6')
        return option_t::exit;
    throw runtime_error("no such option");
}

void input_and_update_type() {
    cout << "availiable types : ";
    for (auto p : type_map)
        cout << p.second << ',';
    cout << "\b." << endl << "choose one : ";
    string inp = input_string();
    auto elem = find_if(type_map.cbegin(), type_map.cend(), 
        [inp](const pair<type_t, string>& p){
        return p.second == inp;
    });
    if (elem == type_map.cend())
        throw runtime_error("no such type");
    current_options::type = elem->first;
}

void input_and_update_value() {
    cout << "input new value : ";
    string in = input_string();
    switch (current_options::type) {
        case type_t::_int:
            parse_and_update_ints<int>(in);
            break;
        case type_t::_uint:
            parse_and_update_unsigned_ints<unsigned int>(in);
            break;
        case type_t::_char:
            parse_and_update_ints<char>(in);
            break;
        case type_t::_uchar:
            parse_and_update_unsigned_ints<unsigned char>(in);
            break;
        case type_t::_float:
            parse_and_update_floats<float>(in);
            break;
        case type_t::_double:
            parse_and_update_floats<double>(in);
            break;
    }
}

void input_and_update_base() {
    cout << "input new base : ";
    string in = input_string();
    int base = parse_like_ull(in, 10);//10 only!
    if (2 <= base && base <= 36)
        current_options::base = base;
    else throw runtime_error("bad base range (can be only in 2..36)");
}

void input_and_perform_shift() {
    cout << "input direction (left/right) : ";
    string in_direction = input_string();
    bool is_left;
    if (in_direction == "left")
        is_left = true;
    else if (in_direction == "right")
        is_left = false;
    else throw runtime_error("bad direction");
    cout << "input amount : ";
    string in_str = input_string();
    unsigned int amount = parse_like_ull(in_str, 10);
    current_options::buffer.perform_shift(is_left, amount);
}

void input_and_update_color() {
    cout << "input color (";
    for (auto& e : color_map)
        cout << e.first << ' ';
    cout << "\b) : ";
    string in_str = input_string();
    auto element = color_map.find(in_str);
    if (element == color_map.cend())
        throw runtime_error("no such color");
    else 
        current_options::color = element->second;
}

int main(){
    for (;;) {
        system("cls");
        try {
            option_t option = get_option();
            system("cls");
            switch (option) {
                case option_t::type:
                    input_and_update_type();
                    current_options::buffer.reset();
                    break;
                case option_t::base:
                    input_and_update_base();
                    break;
                case option_t::value:
                    input_and_update_value();
                    break;
                case option_t::shift:
                    input_and_perform_shift();
                    break;
                case option_t::color:
                    input_and_update_color();
                    break;
                case option_t::exit:
                    return 0;
            }
        } catch (runtime_error e) {
            system("cls");
            cout << "ERROR: " << e.what() << endl;
            system("pause");
        }
    }
}