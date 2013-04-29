%{
#include "y.tab.h"
#include "tree.h"
%}

%%

[0-9]+					yylval=make_tree(NUM, NULL, NULL); yylval->attribute.ival = atoi(yytext); return NUM;
[a-zA-Z][a-zA-Z0-9]*    yylval=make_tree(IDENT, NULL, NULL); yylval->attribute.name = strdup(yytext); return IDENT;
[(]						return OBRACK;
[)]						return EBRACK;
[+]						return PLUS;
[-]						return MINUS;
[*]						return STAR;
\n                      
[ \t]+                  /* ignore whitespace */;
%%
