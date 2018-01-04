#include <stdio.h>
#include <stdlib.h>
#include "union_find.h"
#include <string.h>
#include <assert.h>

void print_string(void* value) {
    char* str = malloc(sizeof(char)* 500);
    strcpy(str, (char*)value);
    printf(" %s ", str);
}

void print_int(void* value) {
    printf(" %d ", (int) value);
}

void test_union_find_int_singleton() {
    UnionFind* unionFind = UnionFind_new(unionFind, hash_int, 10, compare_int, print_int);

    for (int i = 0; i < UnionFind_get_size(unionFind); i++)
        UnionFind_insert(unionFind, (void*) i);

    for (int i = 0; i < UnionFind_get_size(unionFind); i++) {
        NodeU* node = UnionFind_find_NodeU(unionFind, (void*) i);
        NodeU* parent = UnionFind_find_set(node);
        assert(UnionFind_compareNode(unionFind, node, parent) == 0);
    }
    UnionFind_free(unionFind);
}


void test_union_find_string_singleton() {
    UnionFind* unionFind = UnionFind_new(unionFind, hash_string, 5, compare_string, print_string);
    char** array = (char**) malloc(sizeof(char*) * 5);

    array[0] = "provo";
    array[1] = "a inserire";
    array[2] = "valori";
    array[3] = "a caso";
    array[4] = "per fare i test";

    for (int i = 0; i < 5; i++) {
        UnionFind_insert(unionFind, (void*) array[i]);
    }

    for (int i = 0; i < UnionFind_get_size(unionFind); i++) {
        NodeU* node = UnionFind_find_NodeU(unionFind, (void*) array[i]);
        NodeU* parent = UnionFind_find_set(node);
        assert(UnionFind_compareNode(unionFind, node, parent) == 0);
    }

    UnionFind_free(unionFind);
}


void test_union_find_int_all_same_parent() {
    UnionFind* unionFind = UnionFind_new(unionFind, hash_int, 10, compare_int, print_int);

    for (int i = 0; i < 10; i++)
        UnionFind_insert(unionFind, (void*) i);

    for (int i = 0; i < 9; i++) {
        NodeU* nodeL = UnionFind_find_NodeU(unionFind, (void*) i);
        NodeU* nodeR = UnionFind_find_NodeU(unionFind, (void*) i+1);
        UnionFind_union(nodeL, nodeR);
    }

    NodeU* nodeP = UnionFind_find_set(UnionFind_find_NodeU(unionFind, (void *) 0));

    for (int i = 0; i < UnionFind_get_size(unionFind); i++) {
        NodeU* node = UnionFind_find_NodeU(unionFind, (void*) i);
        NodeU* parent = UnionFind_find_set(node);
        assert(UnionFind_compareNode(unionFind, nodeP, parent) == 0);
    }

    UnionFind_free(unionFind);
}


void test_union_find_string_all_same_parent() {
    UnionFind* unionFind = UnionFind_new(unionFind, hash_string, 5, compare_string, print_string);
    char** array = (char**) malloc(sizeof(char*) * 5);

    array[0] = "provo";
    array[1] = "a inserire";
    array[2] = "valori";
    array[3] = "a caso";
    array[4] = "per fare i test";

    for (int i = 0; i < 5; i++) {
        UnionFind_insert(unionFind, (void*) array[i]);
    }

    for (int i = 0; i < 4; i++) {
        NodeU* nodeL = UnionFind_find_NodeU(unionFind, (void*) array[i]);
        NodeU* nodeR = UnionFind_find_NodeU(unionFind, (void*) array[i+1]);
        UnionFind_union(nodeL, nodeR);
    }

    NodeU* nodeP = UnionFind_find_set(UnionFind_find_NodeU(unionFind, (void *) array[0]));

    for (int i = 1; i < UnionFind_get_size(unionFind); i++) {
        NodeU* node = UnionFind_find_NodeU(unionFind, (void*) array[i]);
        NodeU* parent = UnionFind_find_set(node);
        assert(UnionFind_compareNode(unionFind, nodeP, parent) == 0);
    }
    UnionFind_free(unionFind);
}

int main () {
    test_union_find_int_singleton();
    test_union_find_string_singleton();
    test_union_find_int_all_same_parent();
    test_union_find_string_all_same_parent();
    return 0;
}