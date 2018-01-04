//  Copyright 2017 Raileanu Ana Arina
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define DIM 1000
#define MAX_ARGS 10

int cmd_read(int* args_count, char* args[MAX_ARGS]);
void cmd_execute(int args_count, char *args[MAX_ARGS],
                 char **arena, int *size_arena);
void cmd_free(int args_count, char *args[MAX_ARGS]);
void initialize(int args_count, char *args[MAX_ARGS],
                char **arena, int *size_arena);
void finalize(char *arena);
void dump(char *arena, int *size_arena);
void alloc_block(char *arena, int *size_arena, int size_alloc);
void free_block(char* arena, int index);
void fill(char *arena, int index, int size, int value);
void show_arena(char *arena, int size_arena, int type);

int main() {
// cmd: cmd_name argument1 argument2 ...
    // args = {cmd_name, argument1, argument2, ... }
    // args_count = length of args
    int args_count, size_arena;
    char *args[MAX_ARGS];
    char *arena;
    while (1) {
        // read new command from stdin
        if (!cmd_read(&args_count, args)) {
            break;  // no command was found, break loop
        }

        cmd_execute(args_count, args, &arena, &size_arena);  // execute command
        if (!strcmp(args[0], "FINALIZE")) {
            cmd_free(args_count, args);  // free memory allocated for args
            return 0;
        }
        cmd_free(args_count, args);  // free memory allocated for args
    }
    return 0;
}

// read a new command
int cmd_read(int* args_count, char* args[MAX_ARGS]) {
    char buff[DIM + 1];
    if (!fgets(buff, DIM, stdin)) {
        return 0;
    }
    // delete extra '\n'
    int len = strlen(buff);
    if (buff[len - 1] == '\n') {
       buff[len - 1] = '\0';
    }
    // split string in words/numbers
    int count = 0;  // number of words/numbers
    char *aux;
    aux = strtok(buff, " ");  // get first word separated by " "

    while (aux != NULL) {
        len = strlen(aux) + 1;  // +1 for '\0' at the end
        args[count] = (char *) malloc(len * sizeof(char));
        snprintf(args[count], len, "%s", aux);

        // get next word/number
        aux = strtok(NULL, " ");
        ++count;
    }

    *args_count = count;  // store number of arguments
    return 1;  // success
}

// execute commands
void cmd_execute(int args_count, char *args[MAX_ARGS],
                 char **arena, int *size_arena) {
    // call function initialize to allocate memory for arena
    if (!strcmp(args[0], "INITIALIZE")) {
            initialize(args_count, args, &*arena, size_arena);
            // size of arena changes at initialization
            *size_arena = atoi(args[1]);
    }

    // call function dump to display arena
    if (!strcmp(args[0], "DUMP")) {
        dump(*arena, size_arena);
    }

    // call function alloc_block to use a new memory block from arena
    if (!strcmp(args[0], "ALLOC")) {
        alloc_block(*arena, size_arena, atoi(args[1]));
    }

    // call function fill to change value of args[2] number of bytes starting
    // from index args[1] to value args[3]
    if (!strcmp(args[0], "FILL")) {
        fill(*arena, atoi(args[1]), atoi(args[2]), atoi(args[3]));
    }

    // call function free_block to remove a block from arena
    if (!strcmp(args[0], "FREE")) {
        free_block(*arena, atoi(args[1]));
    }

    // call function show_arena to show info about arena
    if (!strcmp(args[0], "SHOW")) {
            // show number of free blocks and free bytes
            if (!strcmp(args[1], "FREE")) {
                // command SHOW FREE was associated with type 1
                show_arena(*arena, *size_arena, 1);
            }

            // show number of used blocks and bytes
            // efficiency & fragmentation
            if (!strcmp(args[1], "USAGE")) {
                // command SHOW USAGE was associated with type 2
                show_arena(*arena, *size_arena, 2);
            }

            // show free/occupied block of memory and its size
            if (!strcmp(args[1], "ALLOCATIONS")) {
                // command SHOW ALLOCATIONS was associated with type 3
                show_arena(*arena, *size_arena, 3);
            }
    }

    // call function finalize to free memory allocated for arena
    if (!strcmp(args[0], "FINALIZE")) {
        finalize(*arena);
        return;
    }
}

// free memory allocated for command arguments
void cmd_free(int args_count, char *args[MAX_ARGS]) {
    int i;
    for (i = 0; i < args_count; i++) {
        free(args[i]);
    }
}

// allocate memory for arena
void initialize(int args_count, char *args[MAX_ARGS],
                 char **arena, int *size_arena) {
    int n_bytes = atoi(args[1]);  // stores number of bytes wanted in arena
    *arena = (char*)calloc(n_bytes, sizeof(char));
    *size_arena = n_bytes;  // store size of arena
}

// free memory allocated for arena
void finalize(char *arena) {
    free(arena);
}

// display arena
void dump(char *arena, int *size_arena) {
    int cnt = 0;  // current byte position
    int i;

    // display all bytes that are inside arena
    while (cnt < *size_arena) {
        // print current index in hex format with 8 digits
        printf("%08X\t", cnt);

        // print 16 bytes on a line
        for (i = 1; i <= 16; i++) {
            if (cnt == *size_arena) {
                break;
            }
            // print current byte value in hex format with 2 digits
            printf("%02X ", (unsigned int)(arena[cnt] & 0xFF));
            ++cnt;
        }
        printf("\n");
    }
    // print last index
    printf("%08X\n", cnt);
}

// add new memory block to use
void alloc_block(char *arena, int *size_arena, int size_alloc) {
    // if arena is empty add new block
    if (*((int*)(arena)) == 0) {
        // check if enough space for new block
        if (*size_arena < size_alloc + 16) {
            printf("0\n");  // fail
            return;
        }

        // allocate block starting from 4th byte
        // first 4 bytes represent start index(int)

        // start index shows where first block starts
        *((int*)(arena)) = sizeof(int);
        // no used block after first block
        *((int*)(arena + sizeof(int))) = 0;
        // no used block before first
        *((int*)(arena + 2 * sizeof(int))) = 0;
        // size of block = size of allocated memory + size of admin. zone
        *((int*)(arena + 3 * sizeof(int))) = size_alloc + 3*sizeof(int);

        // print starting point of data from first block
        printf("%d\n", 4 * sizeof(int));
        return;
    }

    // search arena until it finds enough unused memory for block
    // use 2 blocks(left/right) to jump from one block to another

    // pretend start index is a block
    int r_next = *((int*)(arena));  // next block after the one on the right
    int r_last = 0;  // block before the one on the right
    int r_size = sizeof(int);  // size of block on the right
    // same meaning but for left block
    int l_next, l_size;  // no need to memorise l_last, we move to the right

    // while there is at least a block on the right, move through arena
    while (r_next) {
      // shift position by one block

      // block on left is now block on right
      l_next = r_next;
      l_size = r_size;
      // right block becomes the block after new left block
      r_next = *((int*)(arena + l_next));
      r_last = *((int*)(arena + l_next + sizeof(int)));
      r_size = *((int*)(arena + l_next + 2 * sizeof(int)));

      // check if unused size between blocks >= size of new block
      if (l_next - r_last - l_size >= size_alloc + 3 * sizeof(int)) {
          // place new block immediately after block on left
          int new_index = r_last + l_size;  // index of new block

          // change following block index for block on left
          *((int*)(arena + r_last)) = new_index;
          // change preceding block index for block on right
          *((int*)(arena + l_next + sizeof(int))) = new_index;

          // initialize new block
          *((int*)(arena + new_index)) = l_next;
          *((int*)(arena + new_index + sizeof(int))) = r_last;
          int block_size =  3 * sizeof(int) + size_alloc;
          *((int*)(arena + new_index + 2 * sizeof(int))) = block_size;

          // print starting position of new data block
          printf("%d\n", new_index + 3 * sizeof(int));
          return;  // block placed, end search
      }
    }

    // try to place new block after last block
    // check if unused size after current last block >= size of new block
    if (*size_arena - l_next - r_size >= size_alloc + 12) {
        // place new block immediately after last block
        int new_index = l_next + r_size;  // index of new block

        // change following block index for last block
        *((int*)(arena + l_next)) = new_index;

        // initialize new block
        *((int*)(arena + new_index)) = 0;  // no following block
        *((int*)(arena + new_index + sizeof(int))) = l_next;
        int block_size =  3 * sizeof(int) + size_alloc;
        *((int*)(arena + new_index + 2 * sizeof(int))) = block_size;

        // print starting position for new block
        printf("%d\n", new_index + 3 * sizeof(int));
        return;  // block placed
    }
    printf("0\n");  // enough memory not found
}

// free memory for block previously allocated
void free_block(char* arena, int index) {
    // index of preceding block
    int lst = *((int*)(arena + index - 2 * sizeof(int)));
    // index of following block
    int nxt = *((int*)(arena + index - 3 * sizeof(int)));

    // case when block to be erased is first block
    if (lst == 0) {
        // case when block to be erased is also last block
        if (nxt == 0) {
        *((int*)(arena + lst)) = 0;  // start index becomes 0
        return;
        } else {
            // start index points to second block
            *((int*)(arena + lst)) = nxt;
            // second block has start index behind
            *((int*)(arena + nxt + sizeof(int))) = lst;
            return;
        }
    }

    // case when block to be erased is last block but not first
    if (nxt == 0) {
        *((int*)(arena + lst)) = 0;  // preceding block become last block
        return;
    }

    // if block is between two other blocks

    // change preceding block index for next block
    *((int*)(arena + lst)) = nxt;
    // change following block index for last block
    *((int*)(arena + nxt + sizeof(int))) = lst;
}

// fill arena with given value starting from index
void fill(char *arena, int index, int size, int value) {
    int i;
    for (i = index; i - index < size; i++) {
        arena[i] = value;
    }
}

// show info about arena
void show_arena(char* arena, int size_arena, int type) {
    // first sizeof(int) bytes are always occupied by start index
    int empty_bytes = size_arena - sizeof(int);
    int empty_blocks = 0;  // number of empty blocks
    int used_bytes = 0;  // number of bytes used for data
    int res_bytes = 0;  // total number of reserved bytes, data + admin.
    int n_blocks = 0;  // number of used blocks
    int cur = 0;  // current block starting index
    int nxt =*((int*)(arena));  // next block starting index

    //  jump from used block to used block until last used block is reached
    while (nxt) {
    n_blocks = n_blocks + 1;  // count number of used blocks
    nxt = *((int*)(arena + nxt));  // move to next used block
    }

    // if no used blocks print standard answers
    if (n_blocks == 0) {
        if (type == 1) {
            printf("1 blocks (%d bytes) free\n", empty_bytes);
        }
        if (type == 2) {
            printf("0 blocks (0 bytes) used\n");
            printf("0%% efficiency\n");
            printf("0%% fragmentation\n");
        }
        if (type == 3) {
            printf("OCCUPIED %d bytes\n", sizeof(int));
            printf("FREE %d bytes\n", empty_bytes);
        }
        return;
    }
    // first sizeof(int) bytes are always occupied by start index
    if (type == 3) {
        printf("OCCUPIED %d bytes\n", sizeof(int));
    }
    // cur is start index and nxt is first block
    cur = 0;
    nxt = *((int*)(arena));
    // check if free space between start index and first block
    if (nxt - cur - sizeof(int) > 0) {
        empty_blocks = empty_blocks + 1;
        if (type == 3) {
            printf("FREE %d bytes\n", nxt - cur - sizeof(int));
        }
    }
    // cur is first block and nxt becomes second block
    cur = nxt;
    nxt = *((int*)(arena + cur));

    // jump from used block to used block until last used block is reached
    while (nxt) {
        // size of current block is occupied
        if (type == 3) {
            int aux2 = *((int*)(arena + cur + 2 * sizeof(int)));
            printf("OCCUPIED %d bytes\n", aux2);
        }

        // check if free space between current block and next block
        if (nxt - cur - *((int*)(arena + cur + 2 * sizeof(int))) > 0) {
            empty_blocks = empty_blocks + 1;
            if (type == 3) {
                int aux1 = nxt - cur - *((int*)(arena + cur + 2 * sizeof(int)));
                printf("FREE %d bytes\n", aux1);  // print free space
            }
        }
        
        empty_bytes = empty_bytes - *((int*)(arena + cur + 2 * sizeof(int)));
        int aux3 = *((int*)(arena + cur + 2 * sizeof(int))) - 3 * sizeof(int);
        used_bytes = used_bytes + aux3;
        cur = nxt;
        nxt = *((int*)(arena + cur));
    }

    if (type == 3) {
        printf("OCCUPIED %d bytes\n", *((int*)(arena + cur + 8)));
    }
    if (size_arena - cur - *((int*)(arena + cur + 8)) > 0) {
        empty_blocks = empty_blocks + 1;
        if (type == 3) {
            int aux2 = size_arena - cur - *((int*)(arena + cur + 8));
            printf("FREE %d bytes\n", aux2);
        }
    }
    empty_bytes = empty_bytes - *((int*)(arena + cur + 8));
    used_bytes = used_bytes + *((int*)(arena + cur + 8)) - 12;
    if (type == 1) {
        printf("%d blocks (%d bytes) free\n", empty_blocks, empty_bytes);
    }
    if (type == 2) {
        printf("%d blocks (%d bytes) used\n", n_blocks, used_bytes);
        double eff;
        res_bytes = 4 + n_blocks*12 + used_bytes;
        eff = ((double)used_bytes) / res_bytes;
        eff = eff * 100;
        printf("%d%% efficiency\n", (int)eff);
        double frag;
        frag = ((double)(empty_blocks - 1)) / n_blocks;
        frag = frag * 100;
        printf("%d%% fragmentation\n", (int)frag);
    }
}