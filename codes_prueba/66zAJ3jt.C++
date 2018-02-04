#include <iostream> 
#include <cstring>
#include <algorithm>

class Permutation {
private:
    unsigned int N = 0;

    int* _array;
public:
    Permutation ();
    ~Permutation ();
    Permutation (unsigned int);
    Permutation (unsigned int, int*);
    Permutation (const Permutation&);

    Permutation& operator =(const Permutation&);
    Permutation& operator *=(const Permutation&);

    Permutation next () const;
    Permutation previous () const;

    Permutation& operator ++();
    Permutation& operator --();
    const Permutation operator ++(int);
    const Permutation operator --(int);

    bool operator ==(const Permutation&) const;
    bool operator !=(const Permutation&) const;
    bool operator <=(const Permutation&) const;
    bool operator >=(const Permutation&) const;
    bool operator <(const Permutation&) const;
    bool operator >(const Permutation&) const;

    Permutation inverse () const;

    void operator ()(int*) const;
    int operator [](int) const;
};

Permutation::Permutation (unsigned int s) : N(s) {
    this->_array = new int[this->N];
    for (unsigned int i = 0; i < this->N; ++i) {
        _array[i] = i;
    }
}

Permutation::Permutation (unsigned int s, int* val) : N (s) {
    this->_array = new int[this->N];
    std::memcpy (this->_array, val, this->N * sizeof (int));
}

Permutation::Permutation (const Permutation& val) {
    this->N = val.N;
    this->_array = new int[this->N];
    std::memcpy (this->_array, val._array, this->N * sizeof (int));
}

Permutation::~Permutation () {
    delete[] _array;
}

Permutation& Permutation::operator =(const Permutation& val) {
    if (*this == val) {
        return *this;
    }
    delete[] _array;
    this->N = val.N;
    this->_array = new int[this->N];
    std::memcpy (this->_array, val._array, this->N * sizeof (int));
    return *this;
}

Permutation& Permutation::operator *=(const Permutation& val) {
    int *temp = new int[this->N];
    for (unsigned int i = 0; i < this->N; ++i) {
        temp[i] = this->_array[val._array[i]];
    }

    std::memcpy (this->_array, temp, this->N * sizeof (int));
    delete[] temp;
    return *this;
}

Permutation Permutation::next () const {
    Permutation temp = *this;
    for (int i = (int)this->N - 2; i >= 0; i--) {
        if (temp._array[i] < temp._array[i + 1]) {
            int min = i + 1;
            for (size_t j = i + 1; j < this->N; j++) {
                if ((temp._array[j] < temp._array[min]) && (temp._array[j] > temp._array[i])) {
                    min = j;
                }
            }
            int x = temp._array[i];
            temp._array[i] = temp._array[min];
            temp._array[min] = x;
            for (size_t j = 0; j < (temp.N - i - 1) / 2; j++) {
                x = temp._array[i + 1 + j];
                temp._array[j + i + 1] = temp._array[temp.N - 1 - j];
                temp._array[temp.N - 1 - j] = x;
            }
            return temp;
        }
    }
    for (size_t i = 0; i < temp.N; i++) {
        temp._array[i] = i;
    }
    return temp;
}

Permutation Permutation::previous () const {
    Permutation temp = *this;
    for (int i = (int)temp.N - 2; i >= 0; i--)
        if (temp._array[i] > temp._array[i + 1]) {
            int max = i + 1;
            for (size_t j = i + 1; j < this->N; j++) {
                if ((temp._array[j] > temp._array[max]) && (temp._array[j] < temp._array[i])) {
                    max = j;
                }
            }
            int x = temp._array[i];
            temp._array[i] = temp._array[max];
            temp._array[max] = x;
            for (size_t j = 0; j < (temp.N - i - 1) / 2; j++) {
                x = temp._array[i + 1 + j];
                temp._array[j + i + 1] = temp._array[temp.N - 1 - j];
                temp._array[temp.N - 1 - j] = x;
            }
            return temp;
        }
    for (size_t i = 0; i < temp.N; i++) {
        temp._array[i] = temp.N - i - 1;
    }
    return temp;
}

Permutation& Permutation::operator ++() {
    return *this = this->next ();
}

Permutation& Permutation::operator --() {
    return *this = this->previous ();
}

const Permutation Permutation::operator ++(int) {
    Permutation temp = *this;
    ++(*this);
    return temp;
}

const Permutation Permutation::operator --(int) {
    Permutation temp = *this;
    --(*this);
    return temp;
}

bool Permutation::operator ==(const Permutation& val) const {
    return (!(*this < val) && !(*this > val));
}

bool Permutation::operator !=(const Permutation& val) const {
    return !(*this == val);
}

bool Permutation::operator <(const Permutation& val) const {
    unsigned int k = std::max (this->N, val.N);
    for (unsigned int i = 0; i < k; i++) {
        if (i < std::min (this->N, val.N)) {
            if (this->_array[i] != val._array[i]) return this->_array[i] < val._array[i];
        }
        else {
            return this->N < val.N;
        }
    }
    return 0;
}

bool Permutation::operator >(const Permutation& val) const {
    return (val < *this);
}

bool Permutation::operator <=(const Permutation& val) const {
    return (*this == val || *this < val);
}

bool Permutation::operator >=(const Permutation& val) const {
    return (*this == val || *this > val);
}

Permutation Permutation::inverse () const {
    Permutation temp (this->N);
    for (size_t i = 0; i < this->N; ++i) {
        temp._array[this->_array[i]] = i;
    }
    return temp;
}

void Permutation::operator ()(int* val) const {
    int* temp = new int[this->N];
    for (unsigned int i = 0; i < this->N; ++i) {
        temp[this->_array[i]] = val[i];
    }
    std::memcpy (val, temp, this->N * sizeof (int));
    delete[] temp;
}

int Permutation::operator [](int index) const {
    return this->_array[index];
}

Permutation operator *(const Permutation& val_1, const Permutation& val_2) {
    Permutation left = val_1, right = val_2;
    return (left *= right);
}