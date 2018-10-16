MAKE = make
EXEC = PL-NEXT-SYNTAX
FILES = plnextyacc.tab.c lex.yy.c
YACC = plnextyacc.y
LEX = plnextlex.l
CLEANEDFILES = lex.yy.c plnextyacc.tab.* *.output

all:
	$(MAKE) yacc
	$(MAKE) lex
	gcc -o $(EXEC) $(FILES)

yacc:
	bison -d $(YACC)

lex:
	flex $(LEX)

clean:
	rm -f $(EXEC) $(CLEANEDFILES)
