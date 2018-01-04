/* Copyright (c) Alexei Gerasimov, licensed under the GNU GPL version 3 */

#include "ircd.h"

static struct mempool leaf_pool, bucket_pool;

#define SUBTRIE_THRESHOLD 4

void init_trie(void)
{
	init_pool(&leaf_pool, sizeof(struct leaf));
	init_pool(&bucket_pool, sizeof(struct bucket));
}

void uninit_trie(void)
{
	uninit_pool(&leaf_pool);
	uninit_pool(&bucket_pool);
}

static void destroy_leaves(struct bucket *bp)
{
	struct leaf *walker, *lp;

	walker = bp->b_child.b_leaf_list;

	while (walker != NULL) {
		lp = walker;
		walker = walker->l_next;

		pfree(leaf_pool, lp);
	}
}

static void
destroy_bucket(
	struct trie	*trie,
	struct bucket	*bp)
{
	int		i, len;

	if (bp == NULL) {
		return;
	}

	if (bp->b_leaf != NULL) {
		pfree(leaf_pool, bp->b_leaf);
	}

	if (bp->b_lnum < SUBTRIE_THRESHOLD) {
		destroy_leaves(bp);

	} else {
		for (i = 0, len = trie->end - trie->start + 1; i < len; ++i) {
			destroy_bucket(tp, (*bp->b_child.b_subtrie)[i]);
		}
		free(bp->b_child.b_subtrie);
	}

	if (bp != &trie->root) {
		pfree(bucket_pool, bp);
	}
}

void destroy_trie(struct trie *trie)
{
	ASSERT(trie != NULL);
	destroy_bucket(trie, &trie->root);
}

static void alloc_bucket(struct bucket **bpp)
{
	struct bucket *bp;

	if (*bpp != NULL) {
		return;
	}

	bp = palloc(bucket_pool);
	bp->b_leaf = NULL;
	bp->b_lnum = 0;
	bp->b_child.b_leaf_list = NULL;

	*bpp = bp;
}

/*
 * - bucket                - bucket
 *    |- leaf "aa"            |- bucket "a"
 *    |- leaf "ba"     ->     |   |- leaf "a"
 *    |- leaf "ab"            |   `- leaf "b"
 *    `- leaf "bb"            `- bucket "b"
 *                                |- leaf "a"
 *                                `- leaf "b"
 */
static void burst_bucket(struct trie *tp, struct bucket *bp)
{
	struct bucket *(*stp)[], *sbp;
	struct leaf *wp, *lp;
	int i;

	stp = calloc(tp->end - tp->start + 1, sizeof(void *));

	for (wp = bp->b_child.b_leaf_list; wp != NULL;) {
		lp = wp;
		wp = wp->l_next;

		i = TOUPPER((lp->l_query++)[0]) - tp->start;
		alloc_bucket(&(*stp)[i]);

		sbp = (*stp)[i];

		if (*lp->l_query != '\0') {
			lp->l_next = sbp->b_child.b_leaf_list;
			sbp->b_child.b_leaf_list = lp;
			++sbp->b_lnum;

		} else {
			sbp->b_leaf = lp;
		}
	}

	bp->b_child.b_subtrie = stp;
}

void trie_add(struct trie *trie, const char *query, void *value)
{
	struct bucket *bucket;
	struct leaf *leaf;

	ASSERT(trie != NULL);
	ASSERT(query != NULL);

	bucket = &trie->root;

	while (query[0] != '\0') {

		if (++bucket->b_lnum == SUBTRIE_THRESHOLD) {
			burst_bucket(trie, bucket);
		}

		if (bucket->b_lnum >= SUBTRIE_THRESHOLD) {
			alloc_bucket(&(*bucket->b_child.b_subtrie)[
				TOUPPER(query[0]) - trie->start]);

		} else {
			leaf = palloc(leaf_pool);
			leaf->l_next = bucket->b_child.b_leaf_list;
			bucket->b_child.b_leaf_list = leaf;
			leaf->l_query = query;
			leaf->l_data = value;

			return;
		}

		bucket = (*bucket->b_child.b_subtrie)[
			TOUPPER(query[0]) - trie->start];
		++query;
	}

	leaf = palloc(leaf_pool);
	bucket->b_leaf = leaf;
	leaf->l_query = query;
	leaf->l_data = value;
}

static void destroy_leaf(struct bucket *bp, const char *sp)
{
	struct leaf *wp, *pp;

	for (pp = NULL, wp = bp->b_child.b_leaf_list; wp != NULL;
	     pp = wp, wp = wp->l_next) {

		if (stricmp(wp->l_query, sp) == 0) {
			if (pp != NULL) {
				pp->l_next = wp->l_next;
			} else {
				bp->b_child.b_leaf_list = wp->l_next;
			}

			pfree(leaf_pool, wp);
			return;
		}
	}
}

/*
 * - bucket                   - bucket
 *    |- bucket "a"              |- leaf "aa"
 *    |   |- leaf "a"     ->     |- leaf "ab"
 *    |   `- leaf "b"            |- leaf "ba"
 *    `- bucket "b"              `- leaf "bb"
 *        |- leaf "a"
 *        `- leaf "b"
 */
static void collapse_trie(struct trie *tp, struct bucket *bp)
{
	struct leaf *wp, *lp, *llp;
	struct bucket *sbp;
	int i, len;

	llp = NULL;
	bp->b_lnum = 0;

	for (i = 0, len = tp->end - tp->start + 1; i < len; ++i) {

		if ((sbp = (*bp->b_child.b_subtrie)[i]) != NULL) {

			if (sbp->b_lnum == SUBTRIE_THRESHOLD) {
				collapse_trie(tp, sbp);
			}

			if (sbp->b_leaf != NULL) {
				--sbp->b_leaf->l_query;
				sbp->b_leaf->l_next = llp;
				llp = sbp->b_leaf;
				++bp->b_lnum;
			}

			for (wp = sbp->b_child.b_leaf_list; wp != NULL;) {
				lp = wp;
				wp = wp->l_next;
				--lp->l_query;
				lp->l_next = llp;
				llp = lp;
				++bp->b_lnum;
			}

			pfree(bucket_pool, sbp);
		}
	}

	free(bp->b_child.b_subtrie);
	bp->b_child.b_leaf_list = llp;
}

void trie_delete(struct trie *tp, const char *sp)
{
	struct bucket	*bp, *pp;
	int		i = 0;

	ASSERT(tp != NULL);
	ASSERT(sp != NULL);

	pp = NULL;
	bp = &tp->root;

	do {
		if (*sp == '\0') {
			if (bp->b_leaf != NULL) {
				pfree(leaf_pool, bp->b_leaf);
				bp->b_leaf = NULL;
			}
			return;

		} else {
			if (bp->b_lnum == SUBTRIE_THRESHOLD) {
				collapse_trie(tp, bp);
			}

			if (--bp->b_lnum < SUBTRIE_THRESHOLD) {
				destroy_leaf(bp, sp);

				if ((bp->b_lnum == 0) && (bp->b_leaf == NULL)
					&& (pp != NULL)) {
					(*pp->b_child.b_subtrie)[i] = NULL;
					pfree(bucket_pool, bp);
				}
				return;
			}

			pp = bp;
			i = TOUPPER(*sp++) - tp->start;
			bp = (*bp->b_child.b_subtrie)[i];
		}
	} while (bp != NULL);
}

static leaf *find_leaf(struct bucket *bucket, const char *query)
{
	struct leaf *walker, *prev;

	prev = NULL;
	walker = bucket->b_child.b_leaf_list;

	while (walker != NULL) {
		if (stricmp(walker->l_query, query) == 0) {
			if (prev != NULL) {
				prev->l_next = walker->l_next;
				walker->l_next = bucket->b_child.b_leaf_list;
				bucket->b_child.b_leaf_list = walker;
			}

			return walker;
		}

		prev = walker;
		walker = walker->l_next;
	}

	return NULL;
}

void *trie_lookup(struct trie *trie, const char *query)
{
	struct bucket *bucket;
	struct leaf *leaf;

	ASSERT(trie != NULL);
	ASSERT(query != NULL);

	bucket = &trie->root;

	while (*query != '\0') {
		if (bucket->b_lnum < SUBTRIE_THRESHOLD) {
			leaf = find_leaf(bucket, query);
			if (leaf == NULL) {
				return NULL;
			}

			return leaf->l_data;
		}

		bucket = (*bucket->b_child.b_subtrie)[
			TOUPPER(*query) - trie->start];

		if (bucket == NULL) {
			return NULL;
		}

		++query;
	}

	if (bucket->b_leaf == NULL) {
		return NULL;
	}

	return bucket->b_leaf->l_data;
}