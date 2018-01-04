/**
 * File: memSystem.c
 * Author: Max Cooper
 * Purpose: To emulate a memory system.
 */

// INCLUDES
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include "memSystem.h"

// DEFINES

// STRUCTS

typedef struct memSystem SYSTEM;
typedef struct memCache CACHE;
typedef struct memSet SET;
typedef struct memLine LINE;

struct memSystem {
    uint32_t * main_mem;
    int mem_size;
    CACHE ** caches;
    int number_caches;
    int number_sets;
    int set_bits;
    int word_bits;
    int lines_per_set;
};

struct memCache {
    SET ** sets;
    int totalReads;
    int readHits;
    int totalWrites;
    int writeHits;

    uint64_t event_stamp;
};

struct memSet {
    LINE ** lines;
};

struct memLine {
    int valid; // Flag to tell whether line holds a block.
    int tag; // Upper bits of addresses of words/bytes in the block.
    int dirty; // Whether block has been modified since loading.
    int lru; // Used for implementation of LRU policy.
    int words_per_block;
    void * block;
};

// PROTOTYPES

void * initializeMemorySystem(unsigned int memoryLength, 
                              unsigned int numberOfCaches, 
                              unsigned int wordsPerBlock, 
                              unsigned int numberOfSets, 
                              unsigned int linesPerSet);

int readInt(void * handle, unsigned int CACHE, unsigned int address);

float readFloat(void * handle, unsigned int CACHE, unsigned int address);

void writeInt(void * h, unsigned int CACHE, unsigned int address, int value);

void writeFloat(void * h, unsigned int CACHE, unsigned int address, 
                float value);

void lock(void * h, unsigned int CACHE);

void unlock(void * h, unsigned int CACHE);

void printStatistics(void * h);

static int is_power_of_2(int number);

static int find_writable_line(SET *, int);


// CODE

void * initializeMemorySystem(unsigned int memoryLength,
                              unsigned int numberOfCaches,
                              unsigned int wordsPerBlock,
                              unsigned int numberOfSets,
                              unsigned int linesPerSet){

    // memoryLength must be a power of 2.
    if (!(is_power_of_2(memoryLength))){
        fprintf(stderr, "Memory Length is not a power of 2\n");
        return NULL;
    }

    // wordsPerBlock must be a power of 2.
    if (!(is_power_of_2(wordsPerBlock))){
        fprintf(stderr, "Number of words per block is not a power of 2\n");
        return NULL;
    }

    // numberOfSets must be a power of 2.
    if (!(is_power_of_2(numberOfSets))){
        fprintf(stderr, "Number of sets is not a power of 2\n");
        return NULL;
    }

    // The product of wordsPerBlock and numberOfSets cannot be greater
    // than memoryLength.
    if ((wordsPerBlock * numberOfSets) > (memoryLength - 1)){
        fprintf(stderr, "Product of words per block and number of sets is"
                " not less than the allotted memory length.\n");
        return NULL;
    }

    // Number of CACHEs must be 1. This is a lab requirement and will be
    // removed when this code is reused for program 6.
    if (numberOfCaches != 1){
        fprintf(stderr, "Initialization did not specify a single CACHE.\n");
        return NULL;
    }

    SYSTEM * memorySystem = malloc(sizeof(SYSTEM));
    if (memorySystem == NULL){
        fprintf(stderr, "MemSystem creation failed\n");
        exit(-1);
    }
    memorySystem->number_caches = numberOfCaches;
    memorySystem->mem_size = memoryLength;
    memorySystem->number_sets = numberOfSets;
    memorySystem->lines_per_set = linesPerSet;
    memorySystem->set_bits = numberOfSets;
    for (int x = 0;; x++){
        if (memorySystem->set_bits == 1){
            memorySystem->set_bits = x;
            break;
        }
        memorySystem->set_bits >>= 1;
    }
    //printf("Set_Bits: %d\n", memorySystem->set_bits);
    memorySystem->word_bits = wordsPerBlock;
    for (int x = 0;; x ++){
        if (memorySystem->word_bits == 1){
            memorySystem->word_bits = x;
            break;
        }
        memorySystem->word_bits >>= 1;
    }
    //printf("Word_Bits: %d\n", memorySystem->word_bits);
    memorySystem->main_mem = malloc(sizeof(uint32_t) * memoryLength);

    if (memorySystem->main_mem == NULL){
        fprintf(stderr, "Failed to malloc main memory\n");
        exit(-1);
    }
    
    // Initialization of main memory
    for (int i = 0; i < memoryLength; i++){
        memorySystem->main_mem[i] = 0;
    }

    memorySystem->caches = malloc(sizeof(CACHE *) * numberOfCaches);
    if (memorySystem->caches == NULL){
        fprintf(stderr, "Failed to malloc cache array\n");
        exit(-1);
    }

    // Initialization of memory caches
    for (int i = 0; i < numberOfCaches; i++){
        memorySystem->caches[i] = malloc(sizeof(CACHE));
        if (memorySystem->caches[i] == NULL){
            fprintf(stderr, "Allocating caches failed\n");
            exit(-1);
        }
        CACHE * curCache = memorySystem->caches[i];
        curCache->totalReads = 0;
        curCache->readHits = 0;
        curCache->totalWrites = 0;
        curCache->writeHits = 0;
        curCache->event_stamp = 0;

        curCache->sets = malloc(sizeof(SET *) * numberOfSets);
        if (curCache->sets == NULL){
            fprintf(stderr, "Failed to malloc array of sets\n");
            exit(-1);
        }
        for (int j = 0; j < numberOfSets; j++){
            curCache->sets[j] = malloc(sizeof(SET));
            if (curCache->sets[j] == NULL){
                fprintf(stderr, "Allocating sets failed");
                exit(-1);
            }
            SET * curSet = curCache->sets[j];
            curSet->lines = malloc(sizeof(LINE *) * linesPerSet);
            if (curSet->lines == NULL){
                fprintf(stderr, "Failed to malloc array of lines\n");
                exit(-1);
            }
            for (int k = 0; k < linesPerSet; k++){
                curSet->lines[k] = malloc(sizeof(LINE));
                if (curSet->lines[k] == NULL){
                    fprintf(stderr, "Allocating lines failed");
                    exit(-1);
                }
                LINE * curLine = curSet->lines[k];
                
                curLine->valid = 0;
                curLine->tag = 0;
                curLine->dirty = 0;
                curLine->lru = 0;
                curLine->words_per_block = wordsPerBlock;
                curLine->block = malloc(sizeof(uint32_t) * wordsPerBlock);
                if (curLine->block == NULL){
                    fprintf(stderr, "Allocating blocks failed");
                    exit(-1);
                }
            }
        }
    }

    return (void *) memorySystem;
}

int readInt(void * handle, unsigned int cache, unsigned int address){

    int val = 0;

    SYSTEM * memorySystem = handle;

    if (cache > (memorySystem->number_caches - 1)){
        fprintf(stderr, "Invalid cache number requested\n");
        exit(-1);
    }
    if (address > (memorySystem->mem_size - 1)){
        fprintf(stderr, "Out of bounds memory address requested\n");
        exit(-1);
    }

    unsigned int wordMask = (0x1 << memorySystem->word_bits) - 1;
    unsigned int setMask = (0x1 << memorySystem->set_bits) - 1;

    unsigned int wordOffset = address & wordMask;
    unsigned int setIndex = ((address >> memorySystem->word_bits) & setMask);
    
    unsigned int tagShift = memorySystem->set_bits + memorySystem->word_bits;
    unsigned int addressTag = (address >> tagShift);

    CACHE * targetCache = memorySystem->caches[cache]; // Grab target cache
    SET * targetSet = targetCache->sets[setIndex];

    for (int i = 0; i < memorySystem->lines_per_set; i++){
        unsigned int foundTag = targetSet->lines[i]->tag;
        if (foundTag == addressTag && targetSet->lines[i]->valid){
            val = *(int *) (targetSet->lines[i]->block + wordOffset);
            printf("Int val found on read: %d\n", val);
            targetSet->lines[i]->lru = (targetCache->event_stamp++);
            targetCache->readHits++;
            targetCache->totalReads++;
            return val;
        }
    }

    int lineOffset = find_writable_line(targetSet, memorySystem->lines_per_set); 

    /**if (targetSet->lines[lineOffset]->dirty){
        targetSet->lines[lineOffset]->dirty = 0;
        for (int i = 0;i < targetSet->lines[lineOffset]->words_per_block;i++){
            int copyBlock = (address - wordOffset)
        }
    }*/

    targetSet->lines[lineOffset]->valid = 1;
    targetSet->lines[lineOffset]->tag = addressTag;
    targetSet->lines[lineOffset]->block = (memorySystem->main_mem + 
                                          (address - wordOffset));
    targetSet->lines[lineOffset]->lru = (targetCache->event_stamp++);
    targetCache->totalReads++;

    val = *(int *) (targetSet->lines[lineOffset]->block + wordOffset);

    printf("Int val found on read: %d\n", val);

    return val;
}

float readFloat(void * handle, unsigned int cache, unsigned int address){
    float val = 0;

    SYSTEM * memorySystem = handle;

    if (cache > (memorySystem->number_caches - 1)){
        fprintf(stderr, "Invalid cache number requested\n");
        exit(-1);
    }
    if (address > (memorySystem->mem_size - 1)){
        fprintf(stderr, "Out of bounds memory address requested\n");
        exit(-1);
    }

    unsigned int wordMask = (0x1 << memorySystem->word_bits) - 1;
    unsigned int setMask = (0x1 << memorySystem->set_bits) - 1;

    unsigned int wordOffset = address & wordMask;
    unsigned int setIndex = ((address >> memorySystem->word_bits) & setMask);
    
    unsigned int tagShift = memorySystem->set_bits + memorySystem->word_bits;
    unsigned int addressTag = (address >> tagShift);

    CACHE * targetCache = memorySystem->caches[cache]; // Grab target cache
    SET * targetSet = targetCache->sets[setIndex];

    for (int i = 0; i < memorySystem->lines_per_set; i++){
        unsigned int foundTag = targetSet->lines[i]->tag;
        if (foundTag == addressTag && targetSet->lines[i]->valid){
            val = *(float *) (targetSet->lines[i]->block + wordOffset);
            targetSet->lines[i]->lru = (targetCache->event_stamp++);
            targetCache->readHits++;
            targetCache->totalReads++;
            return val;
        }
    }

    int lineOffset = find_writable_line(targetSet, memorySystem->lines_per_set); 

    targetSet->lines[lineOffset]->valid = 1;
    targetSet->lines[lineOffset]->tag = addressTag;
    targetSet->lines[lineOffset]->block = (memorySystem->main_mem +
                                          (address - wordOffset));
    targetSet->lines[lineOffset]->lru = (targetCache->event_stamp++);
    targetCache->totalReads++;

    val = *(float *) (targetSet->lines[lineOffset]->block + wordOffset);

    return val;
}

void writeInt(void * h, unsigned int cache, unsigned int address, int value){

    SYSTEM * memorySystem = h;

    if (cache > (memorySystem->number_caches - 1)){
        fprintf(stderr, "Invalid cache number requested\n");
        exit(-1);
    }
    if (address > (memorySystem->mem_size - 1)){
        fprintf(stderr, "Out of bounds memory address requested\n");
        exit(-1);
    }

    unsigned int wordMask = (0x1 << memorySystem->word_bits) - 1;
    unsigned int setMask = (0x1 << memorySystem->set_bits) - 1;

    unsigned int wordOffset = address & wordMask;
    unsigned int setIndex = ((address >> memorySystem->word_bits) & setMask);
    
    unsigned int tagShift = memorySystem->set_bits + memorySystem->word_bits;
    unsigned int addressTag = (address >> tagShift);

    CACHE * targetCache = memorySystem->caches[cache]; // Grab target cache
    SET * targetSet = targetCache->sets[setIndex];

    for (int i = 0; i < memorySystem->lines_per_set; i++){
        unsigned int foundTag = targetSet->lines[i]->tag;
        if (foundTag == addressTag && targetSet->lines[i]->valid){
            //val = *(float *) targetSet->lines[i]->block[wordOffset];
            *(int *) (targetSet->lines[i]->block + wordOffset) = value;
            //printf("Value %d written in line %d of set %d\n", value, i, setIndex);
            targetSet->lines[i]->dirty = 1;
            printf("Val written: %d\n", *(int *) (targetSet->lines[i]->block + wordOffset));
            targetSet->lines[i]->lru = (targetCache->event_stamp++);
            targetCache->writeHits++;
            targetCache->totalWrites++;
            return;
        }
    }

    int lineOffset = find_writable_line(targetSet, memorySystem->lines_per_set); 

    targetSet->lines[lineOffset]->valid = 1;
    targetSet->lines[lineOffset]->tag = addressTag;
    targetSet->lines[lineOffset]->block = (memorySystem->main_mem + 
                                          (address - wordOffset));
    targetSet->lines[lineOffset]->dirty = 1;
    targetSet->lines[lineOffset]->lru = (targetCache->event_stamp++);
    *(int *) (targetSet->lines[lineOffset]->block + wordOffset) = value;
    printf("Val written: %d\n", *(int *) (targetSet->lines[lineOffset]->block + wordOffset));
    targetCache->totalWrites++;
}

void writeFloat(void * h, unsigned int cache, unsigned int address,
                float value){

    SYSTEM * memorySystem = h;

    if (cache > (memorySystem->number_caches - 1)){
        fprintf(stderr, "Invalid cache number requested\n");
        exit(-1);
    }
    if (address > (memorySystem->mem_size - 1)){
        fprintf(stderr, "Out of bounds memory address requested\n");
        exit(-1);
    }

    unsigned int wordMask = (0x1 << memorySystem->word_bits) - 1;
    unsigned int setMask = (0x1 << memorySystem->set_bits) - 1;

    unsigned int wordOffset = address & wordMask;
    unsigned int setIndex = ((address >> memorySystem->word_bits) & setMask);
    
    unsigned int tagShift = memorySystem->set_bits + memorySystem->word_bits;
    unsigned int addressTag = (address >> tagShift);

    CACHE * targetCache = memorySystem->caches[cache]; // Grab target cache
    SET * targetSet = targetCache->sets[setIndex];

    for (int i = 0; i < memorySystem->lines_per_set; i++){
        unsigned int foundTag = targetSet->lines[i]->tag;
        if (foundTag == addressTag && targetSet->lines[i]->valid){
            //val = *(float *) targetSet->lines[i]->block[wordOffset];
            *(float *) (targetSet->lines[i]->block + wordOffset) = value;
            targetSet->lines[i]->dirty = 1;
            targetSet->lines[i]->lru = (targetCache->event_stamp++);
            targetCache->writeHits++;
            targetCache->totalWrites++;
            return;
        }
    }

    int lineOffset = find_writable_line(targetSet, memorySystem->lines_per_set); 

    targetSet->lines[lineOffset]->valid = 1;
    targetSet->lines[lineOffset]->tag = addressTag;
    targetSet->lines[lineOffset]->block = (memorySystem->main_mem + 
                                          (address - wordOffset));
    *(float *) (targetSet->lines[lineOffset]->block + wordOffset) = value;
    targetSet->lines[lineOffset]->lru = (targetCache->event_stamp++);
    targetSet->lines[lineOffset]->dirty = 1;
    targetCache->totalWrites++;
}

void lock( void * h, unsigned int CACHE){
    return;
}

void unlock(void * h, unsigned int CACHE){
    return;
}

void printStatistics(void * h){
    SYSTEM * memorySystem = h;
    for (int i = 0; i < memorySystem->number_caches; i++){
        CACHE * memCache = memorySystem->caches[i];
        printf("Cache %d:\n", i);
        printf("  total number of reads: %d\n", memCache->totalReads);
        printf("  reads that hit in cache: %d\n", memCache->readHits);
        printf("  total number of writes: %d\n", memCache->totalWrites);
        printf("  writes that hit in cache: %d\n", memCache->writeHits);
    }
}

/**
 * is_power_of_2 - Returns a bool indicating whether or not the passed-in
 * integer is a power of 2.
 *
 * @param number - Number to be processed to see whether it is a power of 2.
 *
 * @return int - 1 if number is power of 2, else 0.
 */
static int is_power_of_2(int number){
    // 1 is the minimum power of 2 (0)
    // Anything less than 1 is definitely not a power of 2.

    while (((number % 2) == 0) && (number > 1)){
        number = number / 2;
    }

    return (number == 1);

}

static int find_writable_line(SET * sp, int lines_per_set){
    int writable_index = 0;

    int current_lru = sp->lines[0]->lru;
    for (int i = 0; i < lines_per_set; i++){
        if (sp->lines[i]->valid == 0){
            writable_index = i;
            break;
        }
        if (sp->lines[i]->lru < current_lru){
            current_lru = sp->lines[i]->lru;
            writable_index = i;
        }
    }
    return writable_index;
}