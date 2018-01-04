#pragma once

#include <iostream>
#include <iterator>
#include <cstring>

template <typename T>
class Deque;

template <typename T, class Container>
class Iterator;

template <typename T>
class Deque {
private:
    static const size_t INIT_SIZE_ = 10;// 1024;
    size_t begin_, end_, size_;
    T* data_;
    void grow_ (bool side) {
        int add_ = size_ / 2;
        T* buf = new T[size_];
        std::memcpy (buf, data_, size_ * sizeof (T));
        delete[] data_;
        data_ = new T[size_ + add_];
        std::memset (data_, 0, sizeof (T) * (size_ + add_));
        if (side == 0) {
            begin_ += add_;
            end_ += add_;
            std::memcpy (data_ + add_, buf, size_ * sizeof (T));
        }
        else {
            std::memcpy (data_, buf, size_ * sizeof (T));
        }
        size_ += add_;
        delete[] buf;
    }

public:
    typedef T value_type;
    typedef T& reference;
    typedef const T& const_reference;
    typedef T* pointer;
    typedef const T* const_pointer;
    typedef std::ptrdiff_t difference_type;
    typedef int size_type;

    typedef Iterator<T, Deque<T>> iterator;
    typedef Iterator<const T, const Deque<T>> const_iterator;
    typedef std::reverse_iterator<iterator> reverse_iterator;
    typedef std::reverse_iterator<const_iterator> const_reverse_iterator;

    void print () {
        std::cout << "START " << begin_ << " , END " << end_ << " SIZE " << size () << " DATA : " << "\n";
        for (size_t i = 0; i < size_; ++i) {
            std::cout << data_[i] << " ";
        }
        std::cout << "\n";
    }

    Deque () {
        size_ = INIT_SIZE_;
        begin_ = size_ / 2 - 1;
        end_ = size_ / 2 - 1;
        data_ = new value_type[size_];
    }
    Deque (const Deque& deque) {
        size_ = deque.size_;
        begin_ = deque.begin_;
        end_ = deque.end_;
        data_ = new value_type[size_];
        std::memcpy (data_, deque.data_, sizeof (value_type) * size_);
    }

    Deque& operator =(const Deque& deque) {
        size_ = deque.size_;
        begin_ = deque.begin_;
        end_ = deque.end_;
        delete[] data_;
        data_ = new value_type[size_];
        std::memcpy (data_, deque.data_, size_ * sizeof (value_type));
        return *this;
    }

    ~Deque () {
        delete[] data_;
    }

    void push_back (const T& value) {
        if (end_ == size_ - 1) {
            grow_ (1);
        }
        data_[end_++] = value;
    }
    void push_front (const T& value) {
        if (begin_ == 1) {
            grow_ (0);
        }
        data_[--begin_] = value;
    }
    void pop_back () {
        std::memset (data_ + --end_, 0, sizeof (value_type));
    }
    void pop_front () {
        std::memset (data_ + begin_++, 0, sizeof (value_type));
    }

    T& operator[](size_type ind) {
        return data_[begin_ + ind];
    }
    const T& operator[](size_type ind) const {
        return data_[begin_ + ind];
    }

    T& front () {
        return data_[begin_];
    }
    T& back () {
        return data_[end_ - 1];
    }
    const T& front () const {
        return data_[begin_];
    }
    const T& back () const {
        return data_[end_ - 1];
    }

    bool empty () const {
        return end_ == begin_;
    }
    size_type size () const {
        return end_ - begin_;
    }

    iterator begin () {
        return iterator (this, 0);
    }
    iterator end () {
        return iterator (this, end_ - begin_);
    }
    reverse_iterator rbegin () {
        return reverse_iterator (end());
    }
    reverse_iterator rend () {
        return reverse_iterator (begin());
    }

    const_iterator begin () const {
        return const_iterator (this, 0);
    }
    const_iterator end () const {
        return const_iterator (this, end_ - begin_);
    }
    const_reverse_iterator rbegin () const {
        return const_reverse_iterator (end());
    }
    const_reverse_iterator rend () const {
        return const_reverse_iterator (begin());
    }

    const_iterator cbegin () const {
        return const_iterator (this, 0);
    }
    const_iterator cend () const {
        return const_iterator (this, end_ - begin_);
    }
    const_reverse_iterator crbegin () const {
        return const_reverse_iterator (end());
    }
    const_reverse_iterator crend () const {
        return const_reverse_iterator (begin());
    }
};

template <typename T, class Container>
class Iterator : public std::iterator<std::random_access_iterator_tag, T, std::ptrdiff_t, T*, T&> {
public:
    typedef typename Iterator::iterator_category iterator_category;
    typedef typename Iterator::difference_type difference_type;
    typedef typename Iterator::value_type value_type;
    typedef typename Iterator::reference reference;
    typedef typename Iterator::pointer pointer;

    Iterator () {
        container_ = new Container;
    }

    explicit Iterator (Container* cont, difference_type ind) {
        container_ = cont;
        index_ = ind;
    }
    Iterator (const Iterator& iter) {
        container_ = new Container;
        container_ = iter.container_;
        index_ = iter.index_;
    }

    Iterator& operator =(const Iterator& iter) {
        delete container_;
        container_ = new Container;
        container_ = iter.container_;
        index_ = iter.index_;
        return *this;
    }

    Iterator& operator +=(difference_type mov) {
        index_ += mov;
        return *this;
    }
    Iterator& operator -=(difference_type mov) {
        index_ -= mov;
        return *this;
    }

    Iterator operator +(difference_type mov) const {
        Iterator tmp (*this);
        return tmp += mov;
    }
    Iterator operator -(difference_type mov) const {
        Iterator tmp (*this);
        return tmp -= mov;
    }

    difference_type operator -(const Iterator& iter) const {
        return index_ - iter.index_;
    }

    reference operator *() const {
        return (*container_)[index_];
    }
    reference operator [](difference_type ind) const {
        return (*container_)[index_ + ind];
    }
    pointer operator ->() const {
        return &(*container_)[index_];
    }

    bool operator ==(const Iterator& iter) const {
        return index_ == iter.index_;
    }
    bool operator !=(const Iterator& iter) const {
        return index_ != iter.index_;
    }
    bool operator <=(const Iterator& iter) const {
        return index_ <= iter.index_;
    }
    bool operator >=(const Iterator& iter) const {
        return index_ >= iter.index_;
    }
    bool operator <(const Iterator& iter) const {
        return index_ < iter.index_;
    }
    bool operator >(const Iterator& iter) const {
        return index_ > iter.index_;
    }

    Iterator& operator ++() {
        return *this += 1;
    }
    Iterator& operator --() {
        return *this -= 1;
    }

    Iterator operator ++(int) {
        Iterator tmp (*this);
        *this += 1;
        return tmp;
    }
    Iterator operator --(int) {
        Iterator tmp (*this);
        *this -= 1;
        return tmp;
    }
private:
    difference_type index_;
    Container* container_;
};

template <typename T, class Container>
Iterator<T, Container> operator +(std::ptrdiff_t left, const Iterator<T, Container>& iter) {
    return iter + left;
}