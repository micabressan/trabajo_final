#include <stdio.h>
#include <string.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <dirent.h>

#define MAXINPUTLENGTH 120
#define MAXARGS 20 
#define LEN(array) ((int) (sizeof (array) / sizeof (array)[0]))

typedef struct statement {
  char *argv[MAXARGS];
  FILE *input_redir;
  FILE *output_redir;
  char terminator;
  struct statement *next;
} statement;

statement *currentStatement;

//Split the input into an array of char arrays
void split_spaces(char *buf, char **splitBuf, size_t max){
  char *tempWord;
  tempWord = strtok(buf," ");
  for(int i=0; i<max-1; i++){
    splitBuf[i] = tempWord;
    tempWord = strtok(NULL," ");
  }
}

char *read_line(char *buf, char**bufArray, size_t size) {
  char *getsReturn = fgets(buf, size, stdin);
  char *newLineTest;
  //newLineTest[0] = '\0';
  //get rid of \n in char array
  if((newLineTest = strchr(buf,'\n'))){
    *newLineTest = '\0';
    strcat(buf," ;");
  }
  //split_spaces(buf, currentStatement.argv, MAXARGS);
  bufArray[0]=buf;
  return getsReturn;
}


void read_statement(char **splitBuf){
  statement *thisStatement = malloc(sizeof(statement));
  for(int i = 0; i < MAXARGS; i++){
    if(splitBuf[i+1] == NULL){
      thisStatement->terminator = splitBuf[i][0];
      break;
    }
    thisStatement->argv[i]=splitBuf[i];
  }
  //if(currentStatement == NULL){
    //thisStatement.output_redir = fdopen(STDOUT_FILENO, "a");
  //} else {
    //currentStatement.input_redir
    //thisStatement.output_redir = fdopen(fileno(currentStatement.input_redir),"a");
  //}
  thisStatement->next = currentStatement;
  currentStatement = thisStatement;
}

pid_t execute_statement(statement *stmt) {
  pid_t pid = fork();
  if(pid==0){ //child code
    //Check directories
    execvp(stmt->argv[0],stmt->argv);
    if(errno){
      fprintf(stderr, "Error with command\n");
      exit(0);
    }
  } else { //parent code
    wait(NULL);
  }
  return pid;
}

statement *split_statements(char **inBuf, char *delim) {
  char **statementBuf = malloc(4*MAXINPUTLENGTH);
  for(int j = 0; j < LEN(inBuf); j++){
    char *pointerSave;
    if(inBuf[j] == NULL) {
      break;
    }
    char *tempWord;
    tempWord = strtok_r(inBuf[j],delim,&pointerSave);
    for(int i=0; i<MAXARGS-1; i++){
      statementBuf[i] = tempWord;
      if(tempWord!=NULL){strcat(statementBuf[i],delim);}
      tempWord = strtok_r(NULL,delim,&pointerSave);
    }
  }
  //As split by all terminators, now split by spaces and read into statements
  if (strcmp(delim,"&")==0) {
    for (int i=0; statementBuf[i] != NULL || i < LEN(statementBuf); i++){
      char **spaceStatements = malloc(4*MAXINPUTLENGTH);
      split_spaces(statementBuf[i],spaceStatements,MAXARGS);
      read_statement(spaceStatements);
      free(spaceStatements);
    }
  }
  inBuf = statementBuf;
  free(statementBuf);
}

int main() {
  char inputBuf[MAXINPUTLENGTH];
  char **inputArray = malloc(4*MAXINPUTLENGTH);
  while(1){
    printf("> ");
    inputArray[0] = NULL;
    if(read_line(inputBuf, inputArray, MAXINPUTLENGTH) == NULL){
      break;
    }
    char *delims[3] = {";","|","&"};
    for(int i = 0; i < LEN(delims); i++) {
      split_statements(inputArray, delims[i]);
    }
    printf("break");
    //split_spaces(inputBuf, inputArray, MAXARGS);
    //read_statement(inputArray);
    //if(strcmp(currentStatement.argv[0],"exit")!=0){
      //execute_statement(&currentStatement);
    //} else {
      //break;
    //}
    //currentStatement = NULL;
  }
  free(inputArray);
  printf("Exiting...\n");
}