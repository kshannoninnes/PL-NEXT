%option yylineno

%{
#include <stdio.h>
#include "plnextyacc.tab.h"
%}

 /* These are declared for clarity
    [a-zA-Z]+ isn't exactly intuitive */

number			[0-9]+
ident			[a-z]+
whitespace              [ \t\n\r]+
			
%%

"TERMINATE"		{ printf("TERMINATE"); return TERMINATE; }
"PROGRAM"		{ printf("PROGRAM"); return PROGRAM; }
"END"			{ printf("END"); return END; }
"DECLARATION"		{ printf("DECLARATION"); return DECLARATION; }
"DECL"			{ printf("DECL"); return DECL; }
"TYPE"			{ printf("TYPE"); return TYPE; }
"OF"			{ printf("OF"); return OF; }
"ARR"			{ printf("ARR"); return ARR; }
"IS"			{ printf("IS"); return IS; }
"VAR"			{ printf("VAR"); return VAR; }
"CONST"			{ printf("CONST"); return CONST; }
"TO"			{ printf("TO"); return TO; }
"IMPL"			{ printf("IMPL"); return IMPL; }
"SET"			{ printf("SET"); return SET_ASSIGN; }
"PROC"			{ printf("PROC"); return PROC; }
"FUNC"			{ printf("FUNC"); return FUNC; }
"EXECUTE"		{ printf("EXECUTE"); return EXECUTE; }
"FI"			{ printf("FI"); return FI; }
"THEN"			{ printf("THEN"); return THEN; }
"IF"			{ printf("IF"); return IF; }
"ELIHW"			{ printf("ELIHW"); return ELIHW; }
"OD"			{ printf("OD"); return OD; }
"WHILE"			{ printf("WHILE"); return WHILE; }
"ROF"			{ printf("ROF"); return ROF; }
"DO"			{ printf("DO"); return DO; }
"FOR"			{ printf("FOR"); return FOR; }
"STOP"			{ printf("STOP"); return STOP; }
"START"			{ printf("START"); return START; }

","			{ printf("COMMA"); return COMMA; }
">"			{ printf("GREATER_THAN"); return GREATER_THAN; }
"."			{ printf("PERIOD"); return PERIOD; }
":"			{ printf("COLON"); return COLON; }
"="			{ printf("EQUALS"); return EQUALS; }
";"			{ printf("SEMICOLON"); return SEMICOLON; }
"("			{ printf("O_PAREN"); return O_PAREN; }
")"			{ printf("C_PAREN"); return C_PAREN; }
"{"			{ printf("O_BRACE"); return O_BRACE; }
"}"			{ printf("C_BRACE"); return C_BRACE; }
"["			{ printf("O_SBRACKET"); return O_SBRACKET; }
"]"			{ printf("C_SBRACKET"); return C_SBRACKET; }

[+-]			{ printf("expression_op"); return expression_op; }
[*/]			{ printf("term_op"); return term_op; }
{number}		{ printf("number"); return number; }
{ident}			{ printf("ident"); return ident; }
{whitespace}            { printf("%s", yytext); }


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
        fflush(stdout);
	fprintf(stderr, "\n\nnear line %d: %s", yylineno, s);
        printf("\n");
	exit(1);
}
