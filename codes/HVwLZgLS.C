/* Copyright (c) Alexei Gerasimov, licensed under the GNU GPL version 3 */

#ifndef __BURST_TRIE_H__
#define __BURST_TRIE_H__

struct leaf {
	const char *query;
	void *data;
	struct leaf *next;
};

struct bucket {
	struct leaf *leaf;
	int lnum;
	union {
		struct bucket *(*subtrie)[1];
		struct leaf *leaf_list;
	} child;
};

struct trie {
	int start, end;
	struct bucket root;
};

#define	INIT_TRIE(sc, ec) { (sc), (ec), { NULL, 0, { NULL } } }

extern void init_trie(void);
extern void uninit_trie(void);
extern void destroy_trie(struct trie *)
	__attribute__((nonnull(1)));
extern void trie_add(struct trie *, const char *, void *)
	__attribute__((nonnull(1, 2, 3)));
extern void trie_delete(struct trie *, const char *)
	__attribute__((nonnull(1, 2)));
extern void *trie_lookup(struct trie *, const char *)
	__attribute__((nonnull(1, 2)));

#endif /* __BURST_TRIE_H__ */