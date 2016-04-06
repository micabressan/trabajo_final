//forking.c/*
OS LAB PROGS 22AUG
*/
//sysFromUser.c
#include <stdio.h>
#include <stdlib.h>

int main(){
	char userIp[100], c;
	int a=0;
	printf("\nEnter the string to pass to the system call: ");
	fgets(userIp, 100, stdin);
	
	system(userIp);
	return 0;
}
-------------------------------
//execlProg.c
#include <stdio.h>
#include <unistd.h>
int main(){
	printf("\n\n***start of execlProg.c***");
	printf("\nHello! This prog calls prog kriti.c");
	execl("/home/csestudents/./hello", "./hello", "Hello", NULL);
	printf("\n***end of execlProg.c***\n");
	return 0;
}

-------------------------------
//forking.c
#include <stdio.h>
#include <unistd.h>
int main(){
	printf("\nParent process started...");
	int x;
	x = fork();
	printf("\nForking done...");
	if(x==0){              //inside child process
		printf("\ninside child process...");
		printf("\nHi i am child");
	}
	else{                  //inside parent process
		printf("\ninside paernt process...");
		printf("\nHi i am parent");
	}
	return 0;
}
-------------------------------
//forkingWait.c
#include <stdio.h>
#include <unistd.h>
int main(){
	printf("\nParent process started...");
	int x, status;
	x = fork();
	printf("\nForking done...");
	if(x==0){              //inside child process
		printf("\ninside child process...");
		printf("\nHi i am child");
	}
	else{                  //inside parent process
		wait(&status);
		printf("\ninside paernt process...");
		printf("\nHi i am parent");
	}
	return 0;
}

-------------------------------
//kriti.c
#include <stdio.h>
int main(){
	int a, b;
	printf("\n\n***start of kriti.c***");
	printf("\nHello! This prog prints the sum of two nos.");
	printf("\nPlease enter two numbers: ");
	scanf("%d%d", &a, &b);
	printf("\nThe sum of %d and %d is %d", a, b, a+b);
	printf("\n***end of kriti.c***\n");
	return 0;
}

-----------------------------
//hello.c
#include <stdio.h>
int main(){
	printf("\nHi!! This is hello.c");
	printf("\nhello.c will now end!");
	return 0;
}

-------------------------