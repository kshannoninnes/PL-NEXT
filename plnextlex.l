%option yylineno

%{
#include <stdio.h>
#include "plnextyacc.tab.h"
void print();
%}

 /* These are declared for clarity
    [a-zA-Z]+ isn't exactly intuitive */

number			[0-9]+
ident			[a-zA-Z]+
whitespace		[ \t\n\r]+
			
%%

"TERMINATE"		{ print(); printf("\n"); return TERMINATE; }
"PROGRAM"		{ print(); return PROGRAM; }
"END"			{ print(); return END; }
"DECLARATION"		{ print(); return DECLARATION; }
"DECL"			{ print(); return DECL; }
"TYPE"			{ print(); return TYPE; }
"OF"			{ print(); return OF; }
"ARR"			{ print(); return ARR; }
"IS"			{ print(); return IS; }
"VAR"			{ print(); return VAR; }
"CONST"			{ print(); return CONST; }
"TO"			{ print(); return TO; }
"IMPL"			{ print(); return IMPL; }
"SET"			{ print(); return SET_ASSIGN; }
"PROC"			{ print(); return PROC; }
"FUNC"			{ print(); return FUNC; }
"EXECUTE"		{ print(); return EXECUTE; }
"FI"			{ print(); return FI; }
"THEN"			{ print(); return THEN; }
"IF"			{ print(); return IF; }
"ELIHW"			{ print(); return ELIHW; }
"OD"			{ print(); return OD; }
"WHILE"			{ print(); return WHILE; }
"ROF"			{ print(); return ROF; }
"DO"			{ print(); return DO; }
"FOR"			{ print(); return FOR; }
"STOP"			{ print(); return STOP; }
"START"			{ print(); return START; }

","			{ print(); return COMMA; }
">"			{ print(); return GREATERTHAN; }
"."			{ print(); return PERIOD; }
":"			{ print(); return COLON; }
"="			{ print(); return EQUALS; }
";"			{ print(); return SEMICOLON; }
"("			{ print(); return O_BRACKET; }
")"			{ print(); return C_BRACKET; }
"{"			{ print(); return O_BRACE; }
"}"			{ print(); return C_BRACE; }
"["			{ print(); return O_HBRACKET; }
"]"			{ print(); return C_HBRACKET; }

[+-]			{ print(); return expression_op; }
[*/]			{ print(); return term_op; }
{number}		{ print(); return number; }
{ident}			{ print(); return ident; }
{whitespace}		{ print(); }

%%

void print()
{
	printf("%s", yytext);
}

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
	fprintf(stderr, "%d %s\n", yylineno, s);
	exit(1);
}
