DEBUG=
CFLAGS= -lfl
LFLAGS=-DYYSTYPE=tree_t*

all: lexical syntax
	gcc lex.yy.c y.tab.c tree.c -o dragonling $(CFLAGS) $(LFLAGS)

lexical:
	lex $(DEBUG) lexical.l

syntax:
	yacc $(DEBUG) syntax.y

clean:
	rm -f *.o y.tab.* lex.yy.c dragonling
