/**
 * Implements a dictionary's functionality.
 */

#include <stdbool.h>
#include <stdio.h>
#include "dictionary.h"
#include <stdlib.h>
#include <cs50.h>
#include <string.h>
#include <stdint.h>
#include <ctype.h>

/**
 * Declare nodes.
 */

// make a new struct for the nodes
typedef struct node
{
    bool is_word;
    struct node *children[27];
}
node;

// declare the first node for load
node *root;
node *new_node;
node *tracker;

// declare cursor for unload
node *cursor;
node *trav;

// other functions
bool clearNode(node*);

// declare variables and pointers for size (used by multiple functions)
int dcount = 0;
int* pointdcount = &dcount;;

int ToIndex(char letter)
{
    if (isalpha(letter))
    {
        return (toupper(letter) - 65);
    }
    else
    {
        return 26;
    }
}

/**
 * Returns true if word is in dictionary else false.
 */
bool check(const char *word)
{
        int n = 0;
        int index = 0;
        tracker = root;

        while (word[n] != '\0')
        {
            char letter = word[n];
            index = ToIndex(letter);

            if (tracker->children[index] == NULL)
            {
                return false;
            }
            else if (tracker->children[index] != NULL)
            {
                if (word[n+1] == '\0' && tracker->is_word == true)
                    {
                        return true;
                    }
                else
                {
                    tracker = tracker->children[index];
                    n++;
                }
            }
        }

    return true;
}

/**
 * Loads dictionary into memory. Returns true if successful else false.
 */
bool load(const char *dictionary)
{
    root = malloc(sizeof(node));
    if (root == NULL)
    {
        return false;
    }
    for (int i = 0; i < 27; i++)
    {
        root->children[i] = NULL;
        root->is_word = NULL;
    }

    // for unload()
    cursor = root;

    // declare word array
    char word[LENGTH + 1];

    // open the dictionary identified in speller.c
    FILE *fp = fopen(dictionary, "r");
    if (fp == NULL)
    {
        printf("Could not open %s.\n", dictionary);
        unload();
        return 1;
    }

    // repeat reading into the dictionary one word at a time until EOF
    while (fscanf(fp, "%s", word) != EOF)
    {
        int n = 0;
        int index = 0;

        while (word[n] != '\0')
        {
            char letter = word[n];
            index = ToIndex(letter);

            // first letter
            if (n == 0)
            {
                if (root->children[index] == NULL)
                {
                    new_node = malloc(sizeof(node));
                    root->children[index] = new_node;
                    if (root->children[index] == NULL)
                    {
                        return false;
                    }
                    for (int i = 0; i < 27; i++)
                    {
                        new_node->children[i] = NULL;
                        new_node->is_word = NULL;
                    }
                }
                tracker = root->children[index];
                // printf("%c", word[n]);
                // last letter in word
                if (word[n + 1] == '\0')
                {
                    root->is_word = true;
                    // printf("\n");
                }
                n++;
            }
            // not first letter
            else if (n != 0)
            {
                if (tracker->children[index] == NULL)
                {
                    new_node = malloc(sizeof(node));
                    tracker->children[index] = new_node;
                    if (tracker->children[index] == NULL)
                    {
                        return false;
                    }
                    for (int i = 0; i < 27; i++)
                    {
                        new_node->children[i] = NULL;
                        new_node->is_word = NULL;
                    }
                }
                tracker = tracker->children[index];
                // printf("%c", word[n]);
                // last letter in word
                if (word[n + 1] == '\0')
                {
                    new_node->is_word = true;
                    // printf("\n");
                }
                n++;
            }
        }
        dcount++;
    }
    printf("dcount: %i", dcount);
    return true;
}

/**
 * Returns number of words in dictionary if loaded else 0 if not yet loaded.
 */
unsigned int size(void)
{
    // printf("%i\n", *pointdcount);
    return *pointdcount;
}

/**
 * Unloads dictionary from memory. Returns true if successful else false.
 */

bool unload(void)
{
    trav = cursor;
    clearNode(cursor);
    return true;
}



bool clearNode(node* cursor)
{
    int n = 0;

    for (int i = 0; i < 26; i++)
    {
        // node *trav = cursor;
        while (trav != NULL)
        {
            trav = trav->children[i];
            clearNode(trav);
        }
        if (trav == NULL)
        {
            n++;
        }
        if(n == 27)
        {
            free(trav);
        }


        //for (int j = 0; j < 26; j++)
        {
          //  if (trav->children[j] == NULL)
            {
            //    n++;
            }
            //if (n == 27)
            {
              //  free(trav);
            }
        }
    }
    return true;
}