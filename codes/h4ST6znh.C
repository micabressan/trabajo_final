#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#include "BinarySearchTreeAPI.h"
#include "OtherFunctions.h"

int main (int argc, char * argv[]) {

	//printf("bbb\n");

	char * file = argv[1];
	FILE * readIn = NULL;
	
	char * tempChar;
	char * token;
	char currentLine[50];
	char tempLine[10];
	int condition = 0;
	double tempDouble;
	double oneDouble;

	RData * temp = NULL;
	RData * hold = NULL;
	RData * theone = NULL;

	if (argc < 2) {

		printf("Error: Please provide command line file.\n");
		return 0;
	}

	Tree * RDataTree = createBinTree (compareRData, deleteRData, copyRData);

	readIn = fopen (file, "r");

	if (NULL != readIn) {

		printf("do things\n");

		while (fgets (currentLine, sizeof(currentLine), readIn)) {

			tempChar = malloc(sizeof(char) * strlen(currentLine));

			strncpy (tempChar, currentLine, strlen(currentLine));

			if (tempChar[strlen(currentLine) - 1] == '\n') {
			
				tempChar[strlen(currentLine) - 1] = '\0';
			}

			if (condition == 0) {

				temp = malloc(sizeof(RData));

				for (int i = 0; tempChar[i]; ++i) {

					tempChar[i] = tolower (tempChar[i]);
				}

				temp->keyWord = tempChar;

				++condition;
			}

			else {

				temp->response = tempChar;
				temp->userRating = 0.5;
				temp->systemRating = 0.5;
				temp->occur = 0;

				addToTree (RDataTree, temp);

				--condition;
			}
		}

		fclose (readIn);
	}

	else {

		printf("Error: File Not found\n");

		return 0;
	}

	while (condition < 1) {

		printf("\n");
		printf("Enter a command (0 for command list): ");

		fgets (tempLine, sizeof(tempLine), stdin);

		if (tempLine[0] == '1') {

			printf("\n");
			printf("Enter a new keyword: ");

			fgets (currentLine, sizeof(currentLine), stdin);

			tempChar = malloc(sizeof(char) * strlen(currentLine));
			strncpy (tempChar, currentLine, strlen(currentLine));
			tempChar[strlen(currentLine) - 1] = '\0';

			for (int i = 0; tempChar[i]; ++i) {

				tempChar[i] = tolower (tempChar[i]);
			}

			temp = malloc(sizeof(RData));
			temp->keyWord = tempChar;

			printf("\n");
			printf("Enter a new response (sentence): ");

			fgets (currentLine, sizeof(currentLine), stdin);

			tempChar = malloc(sizeof(char) * strlen(currentLine));
			strncpy (tempChar, currentLine, strlen(currentLine));
			tempChar[strlen(currentLine) - 1] = '\0';

			temp->response = tempChar;

			printf("\n");
			printf("What is the importance of this rule? ");

			fgets(currentLine, sizeof(currentLine), stdin);

			sscanf(currentLine, "%lf", &tempDouble);

			temp->userRating = tempDouble;
			temp->systemRating = tempDouble;
			temp->occur = 0;

			if (NULL == findInTree(RDataTree, temp)) {

				addToTree (RDataTree, temp);
			}

			else {

				printf("\n");
				printf("Error: That keyword already exists.\n");

				RDataTree->deleteFunc(temp);
			}
		}

		else if (tempLine[0] == '2') {

			printf("\n");
			printf("What keyword is to be removed? ");

			fgets (currentLine, sizeof(currentLine), stdin);

			tempChar = malloc(sizeof(char) * strlen(currentLine));
			strncpy (tempChar, currentLine, strlen(currentLine));
			tempChar[strlen(currentLine) - 1] = '\0';

			for (int i = 0; tempChar[i]; ++i) {

				tempChar[i] = tolower (tempChar[i]);
			}

			temp = malloc(sizeof(RData));

			temp->keyWord = tempChar;

			removeFromTree (RDataTree, temp);

			free (tempChar);
			free (temp);
		}

		else if (tempLine[0] == '3') {

			printf("\n");
			printInOrder (RDataTree, printRData);
		}

		else if (tempLine[0] == '4') {

			printf("\n");
			printf("What keyword is being modified? ");

			fgets (currentLine, sizeof(currentLine), stdin);

			tempChar = malloc(sizeof(char) * strlen(currentLine));
			strncpy (tempChar, currentLine, strlen(currentLine));
			tempChar[strlen(currentLine) - 1] = '\0';

			for (int i = 0; tempChar[i]; ++i) {

				tempChar[i] = tolower (tempChar[i]);
			}

			temp = malloc(sizeof(RData));

			temp->keyWord = tempChar;

			hold = findInTree (RDataTree, temp);

			if (NULL == hold) {

				printf("Doesn't exist in the tree.\n");
			}

			else {

				printRData (hold);

				printf("What is the new rating for this keyword? ");

				fgets(currentLine, sizeof(currentLine), stdin);

				sscanf(currentLine, "%lf", &tempDouble);

				hold->userRating = tempDouble;
			}

			free (tempChar);
			free (temp);
		}

		else if (tempLine[0] == '5') {

			printf("\n");
			printf("User: ");

			fgets (currentLine, sizeof(currentLine), stdin);

			token = strtok (currentLine, " \n?");

			temp = malloc(sizeof(RData));

			while (NULL != token) {

				for (int i = 0; token[i]; ++i) {

					token[i] = tolower (token[i]);
				}

				temp->keyWord = token;

				hold = findInTree (RDataTree, temp);

				if (NULL != hold) {

					tempDouble = hold->userRating + hold->systemRating;

					if (NULL == theone) {

						theone = hold;
						oneDouble = tempDouble;
					}

					else if (tempDouble > oneDouble) {

						theone = hold;
						oneDouble = tempDouble;
					}
				}

				token = strtok (NULL, " \n?");
			}

			if (theone != NULL) {

				printf("\n");
				printf("Personal Assistant: %s\n", theone->response);

				printf("\n");
				printf("Personal Assistant: Was this feedback helpful? 'y' or 'n'\n");
				printf("\nUser: ");

				fgets(currentLine, sizeof(currentLine), stdin);

				if (currentLine[0] == 'y') {

					tempDouble = theone->systemRating + ((theone->systemRating * 0.05) / 1);

					theone->systemRating = tempDouble;
				}

				else {

					tempDouble = theone->systemRating - ((theone->systemRating * 0.05) / 1);

					theone->systemRating = tempDouble;
				}
			}

			else {

				printf("\n");
				printf("Sorry, I don't have a response\n");
			}

			theone = NULL;
			free (temp);
		}

		else if (tempLine[0] == '9') {

			printf("\n");
			++condition;
		}
	} 

	destroyBinTree (RDataTree);

	return 0;
}