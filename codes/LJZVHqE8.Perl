#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <ctype.h>
#include <math.h>

enum type
{
   UNDEF,
   OPERATOR,
   VALUE,
   BRACE_LEFT,
   BRACE_RIGHT
};

enum operator
{
   NONE,
   MUL,
   MOD,
   DIV,
   ADD,
   SUB,
   POW
};

union u_type
{
   enum operator op;
   double val;
};

struct token
{
   enum type type;
   union u_type u_type;
};

struct tree
{
   struct token token;

   struct tree *left;
   struct tree *right;
};

int priority(enum operator op)
{
   switch(op)
   {
      case SUB:
      case ADD:
	 return 1;
      case MUL:
      case DIV:
      case MOD:
	 return 2;
      case POW:
	 return 3;
      case NONE:
	 return 0;
   }
   return 0;
}

enum operator char_to_operator(int c)
{
   if(c == '+')
      return ADD;
   else if(c == '-')
      return SUB;
   else if(c == '*')
      return MUL;
   else if(c == '/')
      return DIV;
   else if(c == '%')
      return MOD;
   else if(c == '^')
      return POW;
   
   return NONE;
}

int next_token( char **expr, struct token *token)
{
   if(**expr == '\0')
      return 0;

   if(isdigit(**expr))
   {
      token->type = VALUE;
      token->u_type.val = strtod(*expr, expr);
   }
   else if(**expr == '(')
   {
      token->type = BRACE_LEFT;
      (*expr)++;
   }
   else if(**expr == ')')
   {
      token->type = BRACE_RIGHT;
      (*expr)++;
   }
   else
   {
      token->type = OPERATOR;
      token->u_type.op = char_to_operator(**expr);
      (*expr)++;
   }
  
   return 1;
}

struct tree* create_node(struct tree *left, struct token *token, struct tree *right)
{
   struct tree *node;

   if((node = malloc(sizeof(struct tree))) == NULL)
   {
      perror("malloc ");
      exit(EXIT_FAILURE);
   }
   
   node->token = *token;
   node->left = left;
   node->right = right;

   return node;
}

double calc_tree(struct tree *tree);

double calc_node(struct tree *tree)
{
   assert(tree->token.u_type.op != NONE);

   switch(tree->token.u_type.op)
   {
      case MUL:
	 return calc_tree(tree->left) * calc_tree(tree->right);
      case DIV:
	 return calc_tree(tree->left) / calc_tree(tree->right);
      case ADD:
	 return calc_tree(tree->left) + calc_tree(tree->right);
      case SUB:
	 return calc_tree(tree->left) - calc_tree(tree->right);
      case MOD:
	 return fmod(calc_tree(tree->left), calc_tree(tree->right));
      case POW:
	 return pow(calc_tree(tree->left), calc_tree(tree->right));
      case NONE:
	 return 0.0;
   }
   return 0.0; 
}

/*
  /!\ RECURSIVE /!\
*/
double calc_tree(struct tree *tree)
{
   assert(tree != NULL);
   assert(tree->token.type == OPERATOR || tree->token.type == VALUE);

   switch(tree->token.type)
   {
      case OPERATOR:
	 return calc_node(tree);
      case VALUE:
	 return tree->token.u_type.val;
      default:
	 return 0.0;
   }
   return 0.0;
}



/* 
   Check if the first and the last brace is usefull,
   if not, the function delete them.
   /!\ RECURSIVE /!\
*/
void clean_useless_brace(char **string)
{
   int level;
   char *ptr;
   int min_level;

   ptr = *string;

   if(*ptr == '\0' || *ptr != '(')
      return;

   min_level = 1;
   level = 0;

   while(*ptr != '\0')
   {
      if(*ptr == '(')
	 level++;
      else if(*ptr == ')')
	 level--;

      if(min_level > level && *(ptr+1) != '\0')
	 min_level = level;

      ptr++;
   }
   if(min_level == 1 && **string == '(' && *(ptr-1) == ')')
   {
      **string = '\0';
      *(ptr-1) = '\0';
      (*string)++;
      clean_useless_brace(string);
   }
}

/*
  Divide a string into two string and a token. Check the operators's priority.
  Ex : (5+4)*2 
  Part left  : (5+4)
  Part right : 2
  Token      : *
*/
int divide_string(char *string, char **left, struct token *token, char **right)
{
   int level = 0;
   int token_left = 0;
   struct token cur_token;

   clean_useless_brace(&string);
   token->type = UNDEF;

   *left = string;
   *right = string;

#if 0
   printf("****************\n");
   printf("==>'%s'\n", string);
#endif

   while(next_token(&string, &cur_token))
   {
      if(cur_token.type == OPERATOR)
      {
	 if(level == 0)
	 {
	    if(token->type == UNDEF || (priority(cur_token.u_type.op) <= priority(token->u_type.op)))
	    {
	       token->type = OPERATOR;
	       token->u_type.op = cur_token.u_type.op;
	       *right = string;
	    }
	 }
      }
      else if(cur_token.type == BRACE_LEFT)
      {
	 level++;
      }
      else if(cur_token.type == BRACE_RIGHT)
      {
	 level--;
      }

      if(token->type == UNDEF)
      {
	 *right = string;
      }
      token_left++;
   }

   if(token->type == UNDEF)
   {
      token->type = cur_token.type;
      token->u_type = cur_token.u_type;
   }
   else
   {
      *(*right-1) = '\0';
   }

   if(token->type == VALUE && token_left > 1)
      return 0;
   return (level == 0);
}
void print_token(struct token *token);

/*
  /!\ RECURSIVE /!\
*/
struct tree* build_tree(char *expr, int *error)
{
   struct token token;
   char *right, *left;
   struct tree *tree_left, *tree_right;

   if(*expr == '\0')
   {
      *error = 1;
      return NULL;
   }

   if(divide_string(expr, &left, &token, &right) == 0)
   {
      *error = 1;
      return NULL;
   }

#ifdef DEBUG
   printf("**************\n");
   printf("Left   Token    Right\n");
   printf("'%s'    '", left);
   print_token(&token);
   printf("'      '%s'\n", right);
#endif

   if(token.type == VALUE)
   {
      return create_node(NULL, &token, NULL);
   }
   else if(token.type == OPERATOR)
   {
      tree_left = build_tree(left, error);
      tree_right = build_tree(right, error);
   
      if(tree_left == NULL || tree_right == NULL)
      {
	 *error = 1;
	 return NULL;
      }
      return create_node(tree_left, &token, tree_right);
   }
   else
   {
      *error = 1;
   }
   return NULL;
}

/*
  /!\ RECURSIVE /!\
*/
void free_tree(struct tree *tree)
{
   if(tree != NULL)
   {
      free_tree(tree->left);
      free_tree(tree->right);
      free(tree);
   }
}

#ifdef DEBUG
char *operator_to_string(enum operator op)
{
   assert(op != UNDEF);

   switch(op)
   {
      case MUL:
	 return "*";
      case DIV:
	 return "/";
      case ADD:
	 return "+";
      case SUB:
	 return "-";
      case MOD:
	 return "%";
      case POW:
	 return "^";
      case UNDEF:
	 return "UNDEF";
   }
   return "";
}

void print_token(struct token *token)
{
   switch(token->type)
   {
      case OPERATOR:
	 printf("%s", operator_to_string(token->u_type.op));
	 break;
      case VALUE:
	 printf("%g", token->u_type.val);
	 break;
      case BRACE_LEFT:
	 printf("(");
	 break;
      case BRACE_RIGHT:
	 printf(")");
	 break;
      case UNDEF:
	 printf("UNDEF");
	 break;
   }
}

/*
  /!\ RECURSIVE /!\
*/
void print_tree(struct tree *tree, int prof)
{
   int i;

   for(i = 0; i < prof; i++)
   {
      printf(" -- ");
   }

   if(tree)
   {
      print_token(&(tree->token));
      puts("");
      print_tree(tree->left, prof+1);
      print_tree(tree->right, prof+1);
   }
   else
   {
      printf("||\n");
   }
}
#endif

double calc(char *expr, int  *error)
{
   struct tree *tree;
   double result;

   if((tree = build_tree(expr, error)) == NULL)
      *error = 1;

#ifdef DEBUG
   print_tree(tree, 0);
#endif
   
   if(*error == 0)
      result = calc_tree(tree);

   free_tree(tree);

   return result;
}

int main(int argc, char **argv)
{
   int error = 0;
   double result;

   if(argc != 2)
   {
      printf("Usage : %s <expr>\n", argv[0]);
      return EXIT_FAILURE;
   }

   result = calc(argv[1], &error);

   if(error == 0)
      printf("RESULT : %.2f\n", result);
   else
      printf("Error !\n");

   return EXIT_SUCCESS;
}