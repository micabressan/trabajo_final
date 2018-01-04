#include <iostream>
#include <vector>
#include <algorithm>


template<typename Deque, typename T>
class deque_iterator :public std::iterator < std::random_access_iterator_tag, T>
{
	Deque* deque_ptr;
	size_t index;
public:
	deque_iterator(Deque *p, size_t i) : deque_ptr(p), index(i) 
	{
	}
	deque_iterator& operator=(const deque_iterator& it)
	{
		deque_ptr = it.deque_ptr;
		index = it.index;
		return (*this);
	}
	bool operator==(const deque_iterator& it) const
	{
		return (deque_ptr == it.deque_ptr && index == it.index);
	}
	bool operator!=(const deque_iterator& it) const
	{
		return !(deque_ptr == it.deque_ptr && index == it.index);
	}
	T& operator*()
	{
		return (*deque_ptr)[index];
	}
	T* operator->()
	{
		return &((*deque_ptr)[index]);
	}
	deque_iterator& operator++()
	{
		index++;
		return (*this);
	}
	deque_iterator operator++(int)
	{
		deque_iterator it = *this;
		(*this).operator++();
		return it;
	}
	deque_iterator& operator--()
	{
		index--;
		return (*this);
	}
	deque_iterator operator--(int)
	{
		deque_iterator it = *this;
		(*this).operator--();
		return it;
	}
	deque_iterator& operator+=(const size_t cnt)
	{
		index += cnt;
		return (*this);
	}
	const deque_iterator operator+(const size_t cnt) const
	{
		deque_iterator it = (*this);
		it += cnt;
		return it;
		//return (*(it.operator+=(cnt)));
	}
	deque_iterator& operator-=(const size_t cnt)
	{
		return (*this).operator+=(-cnt);
	}
	const deque_iterator operator-(const size_t cnt) const
	{
		return (*this).operator+(-cnt);
	}
	int operator-(const deque_iterator& it) const
	{
		return int(index) - int(it.index);
	}
	deque_iterator& operator+=(const deque_iterator& it)
	{
		index += it.index;
		return (*this);
	}
	//deque_iterator& operator-=(const deque_iterator& it)
	//{
	//	index -= it.index;
	//	return (*this);
	//}
	const deque_iterator operator+(const deque_iterator& it) const
	{
		deque_iterator it1 = (*this);
		it1 += it;
		return it1;
	}
	//const deque_iterator operator-(const deque_iterator& it) const
	//{
		//deque_iterator it1 = (*this);
	//	it1 -= it;
//		return it1;
	//}
	const T& operator[](const int pos) const
	{
		return (*deque_ptr)[pos];
	}
	T& operator[](const int pos)
	{
		return (*deque_ptr)[pos];
	}
	bool operator>=(const deque_iterator& it) const
	{
		return ((*this).operator-(it) >= 0);
	}
	bool operator>(const deque_iterator& it) const
	{
		return ((*this).operator>=(it) && (*this).operator!=(it));
	}
	bool operator<=(const deque_iterator& it) const
	{
		return !((*this).operator>(it));
	}
	bool operator<(const deque_iterator& it) const
	{
		return !((*this).operator>=(it));
	}
};



template <typename T>
class Deque
{
public:
	std::vector<T> left;
	std::vector<T> right;
	//Deque(Vector v)
	//{
	//	size_t sz = v.end() - v.begin();
	//	for (T* it = v.begin() + sz / 2; it != v.begin(); it--)
	//	{
	//		left.push_back(*it);
	//	}
	//}
	//Deque()
	//{

	//}
	Deque& operator=(const Deque& d1)
	{
		left = d1.left;
		right = d1.right;
		return (*this);
	}
	T& front()
	{
		if (!left.empty())
		{
			return left.back();
		}
		else
		{
			return right.front();
		}
	}
	T& back()
	{
		if (!right.empty())
		{
			return right.back();
		}
		else
		{
			return left.front();
		}
	}
	T front() const
	{
		if (!left.empty())
		{
			return left.back();
		}
		else
		{
			return right.front();
		}
	}
	T back() const
	{
		if (!right.empty())
		{
			return right.back();
		}
		else
		{
			return left.front();
		}
	}
	T& operator[](const int pos)
	{
		//cout << pos << endl;
		if (pos < int(left.size()))
		{
			return left[left.size() - pos - 1];
		}
		else
		{
			return right[pos - left.size()];
		}
	}
	const T& operator[](const int pos) const
	{
		//cout << pos << endl;
		if (pos < int(left.size()))
		{
			return left[left.size() - pos - 1];
		}
		else
		{
			return right[pos - left.size()];
		}
	}
	bool empty() const
	{
		return (left.empty() && right.empty());
	}
	size_t size() const
	{
		return left.size() + right.size();
	}
	void rebuild()
	{
		if (2 * std::min(left.size(), right.size()) <= std::max(left.size(), right.size()))
		{
			//cout << left.size() << ' ' << right.size() << endl;
			std::vector<T> newd(left.size() + right.size());
			std::copy(left.begin(), left.end(), newd.begin());
			//if (!newd.empty())
			//{
			//	cout << newd[0] << endl;
			//}
			std::reverse(newd.begin(), newd.begin() + left.size());
			//if (!newd.empty())
			//{
			//	cout << newd[0] << endl;
			//}

			std::copy(right.begin(), right.end(), newd.begin() + left.size());
			size_t leftsz = (left.size() + right.size()) / 2;
			size_t rightsz = left.size() + right.size() - leftsz;
			//if (!left.empty())
			//{
			//	cout << left[0] << endl;
			//}
			//cout << "!!!!" << endl;
			left.resize(leftsz);
			right.resize(rightsz);
			//if (!left.empty())
			//{
			//	cout << left[0] << endl;
			//}
			//cout << "!!!!" << endl;
			//if (!newd.empty())
			//{
			//	cout << newd[0] << endl;
			//}
			std::copy(newd.begin(), newd.begin() + leftsz, left.begin());
			std::reverse(left.begin(), left.end());
			//for (int i = 0; i < left.size(); i++)
			//{
			//	cout << left[i] << ' ';
			//}
			//cout << endl;
			//cout << left << endl;
			//cout << "!!!!" << endl;
			std::copy(newd.begin() + leftsz, newd.end(), right.begin());
			//cout << "!!!!" << endl;
		}
	}
	void push_back(const T el)
	{
		right.push_back(el);
		rebuild();
	}
	void pop_back()
	{
		rebuild();
		right.pop_back();
		rebuild();
	}
	void push_front(const T el)
	{
		left.push_back(el);
	}
	void pop_front()
	{
		rebuild();
		//cout << left.size() << ' ' << right.size() << endl;
		if (left.empty())
		{
			right.pop_back();
		}
		else
		{
			left.pop_back();
		}
		//cout << left.size() << ' ' << right.size() << endl;
		rebuild();
	}
	typedef deque_iterator<Deque, T> iterator;
	typedef deque_iterator<const Deque, const T> const_iterator;

	typedef std::reverse_iterator<iterator> reverse_iterator;
	typedef std::reverse_iterator<const_iterator> const_reverse_iterator;

	iterator begin()
	{
		return iterator(this, 0);
	}
	iterator end()
	{
		return iterator(this, size());
	}
	const_iterator begin() const
	{
		return const_iterator(this, 0);
	}
	const_iterator cbegin() const
	{
		return const_iterator(this, 0);
	}
	const_iterator end() const
	{
		return const_iterator(this, size());
	}
	const_iterator cend() const
	{
		return const_iterator(this, size());
	}
	reverse_iterator rbegin() 
	{
		return reverse_iterator(end());
	}
	reverse_iterator rend()
	{
		return reverse_iterator(begin());
	}
	const const_reverse_iterator rbegin() const
	{
		return const_reverse_iterator(end());
	}
	const const_reverse_iterator crbegin() const
	{
		return const_reverse_iterator(end());
	}
	const const_reverse_iterator rend() const
	{
		return const_reverse_iterator(begin());
	}
	const const_reverse_iterator crend() const
	{
		return const_reverse_iterator(begin());
	}
};

/*template<typename Deque, typename T>
class deque_iterator :public std::iterator
{
	Deque* deque_ptr;
	size_t index;
public:
	deque_iterator(Deque *p, size_t i) : deque_ptr(p), index(i) {}

	deque_iterator& operator=(deque_iterator it)
	{
		deque_ptr = it.deque_ptr;
		index = it.index;
	}
	bool operator==(const deque_iterator& it) const
	{
		return (deque_ptr == it.deque_ptr && index == it.index);
	}
	bool operator!=(const deque_iterator& it) const
	{
		return !(deque_ptr == it.deque_ptr && index == it.index);
	}
	T& operator*()
	{
		return (*deque_ptr).operator[](index);
		//return (*deque_ptr)[index];
	}
	T* operator->()
	{
		return (*deque_ptr).operator[](index);
		//return deque_ptr + index;
	}
	deque_iterator& operator++()
	{
		index++;
		return (*this);
	}
	deque_iterator operator++(int)
	{
		deque_iterator it = *this;
		(*this).operator++;
		return it;
	}
	deque_iterator& operator--()
	{
		index--;
		return (*this);
	}
	deque_iterator operator--(int)
	{
		deque_iterator it = *this;
		(*this).operator--;
		return it;
	}
	deque_iterator& operator+=(const int cnt)
	{
		index += cnt;
		return (*this);
	}
	deque_iterator operator+(const int cnt) const
	{
		deque_iterator it = (*this);
		return (it += cnt);
	}
	deque_iterator& operator-=(const int cnt)
	{
		return (*this).operator+=(-cnt);
	}
	deque_iterator operator-(const int cnt) const
	{
		return (*this).operator+(-cnt);
	}
	int operator-(deque_iterator& it)
	{
		return index - it.index;
	}
	T operator[](int pos) const
	{
		return (*deque_ptr).operator[](pos);
		//return *(iter + pos);
	}
	bool operator>=(deque_iterator& it) const
	{
		return ((*this).operator-(it) >= 0);
	}
	bool operator>(deque_iterator& it) const
	{
		return ((*this).operator>=(it) && (*this).operator!=(it));
	}
	bool operator<=(deque_iterator& it) const
	{
		return !((*this).operator>(it));
	}
	bool operator<(deque_iterator& it) const
	{
		return !((*this).operator>=(it));
	}
};
*/