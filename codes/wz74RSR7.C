#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    unsigned int size;
    unsigned char *blocks;
} ARENA;

typedef struct {
    unsigned int next, prev, current;
} ZONE;

ARENA initialize ();
//void finalize (ARENA*);
void dump (ARENA);
ARENA alloc (ARENA);

int main (void) {

    freopen ("alocator.in", "r", stdin);
    freopen ("alocator.out", "w", stdout);

    char *cmd = malloc(11 * sizeof(char));
    ARENA arena;

    while (scanf ("%s ", cmd)) {

        if (!strcmp (cmd, "DUMP")) {
            dump (arena);
            continue;
        }

        if (!strcmp(cmd, "ALLOC")) {
            arena = alloc (arena);
        }

        if (!strcmp (cmd, "INITIALIZE")) {
            arena = initialize ();
            if (arena.blocks == NULL) {
                printf ("Nasol, frate...\n");
                break;
            }
            continue;
        }

        if (!strcmp (cmd, "FINALIZE")) {
            free (arena.blocks);
            break;
        }
    }

    free(cmd);
    return 0;
}

ARENA initialize () {
    ARENA arena;

    scanf ("%u\n", &arena.size);
    arena.blocks = (unsigned char*)calloc (arena.size, sizeof(unsigned char));

    return arena;
} // alocarea memoriei pentru arena

void dump (ARENA arena) {
    unsigned char *set, *byte, *begin, *end;
    int i;

    begin = arena.blocks;
    end = arena.blocks + arena.size;

    for (set = begin; (unsigned int)(set - begin) < arena.size; set += 16) {
        printf("%08X\t", (unsigned int)(set - begin));
        byte = set;
        for (i = 0; i < 8 && byte != end; ++i) {
            printf ("%02X ", (unsigned int)*(byte++));
        }
        for (; i < 16 && byte != end; ++i) {
            printf (" %02X", (unsigned int)*(byte++));
        }
        printf ("\n");
    }

    printf("%08X\n", arena.size);
}

ARENA alloc (ARENA arena) {
    unsigned int count, *start = (unsigned int*)arena.blocks;

    scanf ("%d\n", &count);

    if (!*start) {
        *start = 4;
        *(start + 1) = 0;
        *(start + 2) = 0;
        *(start + 3) = count;
    } // prima alocare

    else {

    }

    return arena;
}