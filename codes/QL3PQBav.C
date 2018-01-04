#include <stdio.h>
#include <string.h>
#include "stdafx.h"
#pragma warning(disable:4996)
#define MENU "Please select the operation:\n\t0. Exit.\n\t1. " \
"Insert or update student grades.\n\t2. Delete student" \
"information.\n\t3. Print the student with maximal computed" \
"grade.\n\t4. Print all the students with their computed grades.\n\t5. Print the menu.\n"
#define LINE_CAP 202
#define a  51
#define b  11
#define c  41

int main()
{
	int i;
	int j, k;
	int index;
	int studentsCounter = 0;
	int operation;
	char studentsDatabase[a][b][c];
	char tempArray[202];
	char dummy;
	for (j = 0; j < a; j++) {
		for (k = 0; k < b; k++) {
			studentsDatabase[a][b][0] = '\0';
		}
	}
	printf(MENU);
	scanf("%d%c", &operation, &dummy);
	while (operation != 0) {
		switch (operation)
		{
		case 1:
			fgets(tempArray, LINE_CAP, stdin);
			if (inputCheck(tempArray) == -1) {
				printf("Error: invalid name or grade.\n");
				CleanUp(tempArray);
				break;
			}
			i = UpdateStudentList(tempArray, studentsDatabase, studentsCounter);

			//insert student to i
			break;
		case 2:
			fgets(tempArray, LINE_CAP, stdin);
			if (IsNameValid(tempArray) == -1) {
				printf("Error: invalid name.");
				CleanUp(tempArray);
				break;
			}
			else {
				index=StudentExist(tempArray);
				if ( index == -1) {
					printf("Error: student name does not exist.");
				}
				else {
					CleanUp(studentsDatabase[a][index]);
					MoveRowsUp(index, studentsDatabase);
					prtinf("Student \"%s\" deleted.",tempArray);
				}
			}
			break;
		case 3:
			break;
		case 4:
			break;
		case 5:
			printf(MENU);
			break;
		default:
			printf("Error: unrecognized operation.\n");
			break;
		}
		if ((operation == 1) || (operation == 2) || (operation == 3) || (operation == 4)) {
			printf("Select the next operation (insert 5 for complete menu).\n");
		}
		scanf("%d%c", &operation, &dummy);
	}
	getchar();
	return 0;
}