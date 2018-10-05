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

test:
	@echo ""
	@echo "Testing with good-file"
	@./PL-NEXT-SYNTAX < Testfiles/good-file
	@echo ""
	@echo "Testing with bad-file"
	@./PL-NEXT-SYNTAX < Testfiles/bad-file | true
	@echo ""
