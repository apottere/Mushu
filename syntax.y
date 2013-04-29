%code requires
{
#include "tree.h"
}

%{
#include <stdio.h>
#include <string.h>
#define YYSTYPE tree_t*
 
void yyerror(const char *str)
{
        fprintf(stderr,"error: %s\n",str);
}
 
int yywrap()
{
        return 1;
} 
  
main()
{
        yyparse();
} 

%}

%token IDENT NUM OBRACK EBRACK PLUS MINUS STAR

%%
start:
	 expr
	 {
		print_tree($1, 0);
		printf("%d\n", eval_tree($1));

	 }
	 ;

expr:
	term expr1
	{
//		fprintf( stderr, "EXPRESSION---------------------\n");
//		fprintf( stderr, "DOLLAR 1:\n");
//		print_tree($1, 0);
//		fprintf( stderr, "\n");

//		fprintf( stderr, "DOLLAR 2:\n");
//		print_tree($2, 0);
//		fprintf( stderr, "\n");
//		printf("Found a complete expression!\n");

		if($2 == NULL) {
			$$ = $1;
		} else {
			$2->left = $1;
			$$ = $2;
		}


//		fprintf( stderr, "DOLLAR DOLLAR:\n");
//		print_tree($$, 0);
//		fprintf( stderr, "\n");
//		fprintf( stderr, "-------------------------\n");
	}

expr1:
	 PLUS term expr1
	 {
//		fprintf( stderr, "ADDITION---------------------\n");
//		fprintf( stderr, "DOLLAR 2:\n");
//		print_tree($2, 0);
//		fprintf( stderr, "\n");

//		fprintf( stderr, "DOLLAR 3:\n");
//		print_tree($3, 0);
//		fprintf( stderr, "\n");

	 	if($3 == NULL) {
			$$ = make_tree(PLUS, NULL, $2);
		} else {
			$3->left = $2;
			$$ = make_tree(PLUS, NULL, $3);
		}

//		fprintf( stderr, "DOLLAR DOLLAR:\n");
//		print_tree($$, 0);
//		fprintf( stderr, "\n");
//		fprintf( stderr, "-------------------------\n");
	 }
	 |
	 MINUS term expr1
	 {
//		fprintf( stderr, "SUBTRACTION---------------------\n");
//		fprintf( stderr, "DOLLAR 2:\n");
//		print_tree($2, 0);
//		fprintf( stderr, "\n");

//		fprintf( stderr, "DOLLAR 3:\n");
//		print_tree($3, 0);
//		fprintf( stderr, "\n");

	 	if($3 == NULL) {
			$$ = make_tree(MINUS, NULL, $2);
		} else {
			$3->left = $2;
			$$ = make_tree(MINUS, NULL, $3);
		}
//		fprintf( stderr, "DOLLAR DOLLAR:\n");
//		print_tree($$, 0);
//		fprintf( stderr, "\n");
//		fprintf( stderr, "-------------------------\n");
	 }
	 |
	 {
	 	$$ = NULL;
	 }
	 ;

term:
	factor term1
	{
		if($2 == NULL) {
			$$ = $1;
		} else {
			$2->left = $1;
			$$ = $2;
		}
	}
	;

term1:
	 STAR term
	  {
//	  	printf("\t->Found a star.\n");
		$$ = make_tree(STAR, NULL, $2);
	  }
	 |
	 {
	 	$$ = NULL;
	 }
	 ;

factor:
	  OBRACK expr EBRACK
	  {
	  	$$  = $2;
	  }
	  |
	  NUM
	  {
//	  	printf("\t->Found a number: %d\n", $1->attribute.ival);
		$$ = $1;
	  }
	  |
	  IDENT
	  {
//	  	printf("\t->Found an identifier: %s\n", $1->attribute.name);
		$$ = $1;
	  }
	  ;

%%
