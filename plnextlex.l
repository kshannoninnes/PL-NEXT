%{
#include <stdio.h>
#include "plnextyacc.tab.h"
%}

number			[0-9]+
word			[a-zA-Z]+
whitespace		[ \t\n\r]+
			
%%

"SET"			{ return SET; }
"EXECUTE"		{ return EXECUTE; }
"FI"			{ return FI; }
"THEN"			{ return THEN; }
"IF"			{ return IF; }
"ELIHW"			{ return ELIHW; }
"OD"			{ return OD; }
"WHILE"			{ return WHILE; }
"ROF"			{ return ROF; }
"DO"			{ return DO; }
"FOR"			{ return FOR; }
"STOP"			{ return STOP; }
"START"			{ return START; }

":="			{ return set_equal; }
[+-]			{ return expression_op; }
[*/]			{ return term_op; }

";"			{ return SEMICOLON; }
{number}		{ return number; }
{word}			{ return ident; }
{whitespace}		

%%

int main(void)
{
	yyparse();
	return 0;
}

int yywrap(void)
{
	return 1;
}

void yyerror(char* s)
{
	fprintf(stderr, "%s\n", s);
	exit(1);
}
