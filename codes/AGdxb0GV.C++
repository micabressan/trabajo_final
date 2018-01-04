/* File: Autocomplete.cpp
* Course CS216-004
* Project: 3
* Purpose: Definition of the Autocomplete class
*/

#include "Autocomplete.h"   

//insert the newterm to the sequence
void Autocomplete::insert(Term newterm) {

	terms.insert(newterm);
}

//return all terms whose queries match the given prefix
//in descending order by weight
SortingList<Term> Autocomplete::allMatches(string prefix) {

	SortingList<Term> matches;
	Term t;

	int first = 0, last = 0;
	search(prefix, first, last);

	for (int i = first; i < last; i++) {
		matches.insert(terms[i]);
	}

	int (*compare)(Term, Term);
	compare = &t.compareByWeight;

	matches.selection_sort(compare);

	return matches;
}

//first: the index of the first query whose prefix matches
//  the search key, or -1 if no such key
//last: the index of the last query whose prefixes matches
//  the search key, or -1 if no such key
void Autocomplete::search(string key, int& first, int& last) {
	
	Term k;
	k = Term(key, 0);
	int key_size = key.size();

	int index = binary_search(key);
	int i = index, j = index;
	
	if (index == -1) {			// if key not found
		first = -1;
		last = -1;
	}
	else {

		while (k.compareByPrefix(terms[i], k, key_size) == 0) {
			i--;
		}
		first = i + 1;

		while (k.compareByPrefix(terms[j], k, key_size) == 0) {
			j++;
		}
		last = j - 1;
	}
}

//return the index number of the term whose query 
//prefix-matches the given prefix, using binary search algorithm
//Note that binary search can only be applied to sorted sequence
//Note that you may want a binary search helper function
int Autocomplete::binary_search(string prefix) {

	int low = 0;
	int high = terms.size() - 1;
	int mid;
	
	Term pre;
	pre = Term(prefix, 0);

	terms.sort();
	int preSize = prefix.size() - 1;

	while (low <= high) {

		mid = (low + high) / 2;

		if ( pre.compareByPrefix(terms[mid], pre, preSize) == 0)
			return mid;
		else if (pre.compareByPrefix(terms[mid], pre, preSize) == -1)
			low = mid + 1;
		else
			high = mid + 1;
	}
	return -1;
}

//display all the terms
void Autocomplete::print() {

	int size = terms.size();
	for (int i = 0; i < size; i++) {
		cout << terms[i];
	}
}