%option yylineno

%{
#include <stdio.h>
#include "plnextyacc.tab.h"
%}

 /* These are declared for clarity
    [a-zA-Z]+ isn't exactly intuitive */

number			[0-9]+
ident			[a-zA-Z]+
whitespace		[ \t\n\r]+
			
%%

"TERMINATE"		{ return TERMINATE; }
"PROGRAM"		{ return PROGRAM; }
"END"			{ return END; }
"DECLARATION"		{ return DECLARATION; }
"DECL"			{ return DECL; }
"TYPE"			{ return TYPE; }
"ARR"			{ return ARR; }
"IS"			{ return IS; }
"VAR"			{ return VAR; }
"CONST"			{ return CONST; }
"TO"			{ return TO; }
"IMPL"			{ return IMPL; }
"SET"			{ return SET_ASSIGN; }
"PROC"			{ return PROC; }
"FUNC"			{ return FUNC; }
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

","			{ return COMMA; }
"=>"			{ return TYPEDEC_ASSIGN; }
"."			{ return PERIOD; }
"::"			{ return DOUBLE_COLON; }
":"			{ return COLON; }
":="			{ return FOR_ASSIGN; }
";"			{ return SEMICOLON; }
"("			{ return O_BRACKET; }
")"			{ return C_BRACKET; }
"{"			{ return O_BRACE; }
"}"			{ return C_BRACE; }
"["			{ return O_HBRACKET; }
"]"			{ return C_HBRACKET; }

[+-]			{ return expression_op; }
[*/]			{ return term_op; }
{number}		{ return number; }
{ident}			{ return ident; }
{whitespace}		{ }

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
	fprintf(stderr, "%d %s\n", yylineno, s);
	exit(1);
}
