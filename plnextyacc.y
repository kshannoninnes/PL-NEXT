%error-verbose

%{
#include <stdio.h>
#include <stdlib.h>
int yywrap();
int yylex();
int yyerror();
%}

%token ident number term_op expression_op set_equal
%token START STOP FOR ROF DO OD WHILE ELIHW IF THEN FI EXECUTE SET SEMICOLON
%start input

%%

input: 			basic_program { printf("Test success!\n"); }

basic_program: 		statement
			| basic_program statement

statement:		assignment
			| procedure_call
			| if_statement
			| while_statement
			| do_statement
			| for_statement 
			| compound_statement

assignment:		ident SET expression

procedure_call:		EXECUTE ident

if_statement:		IF expression THEN statement FI

while_statement:	WHILE expression DO statement ELIHW
			| WHILE expression DO statement SEMICOLON statement ELIHW

do_statement:		DO statement WHILE expression OD
			| DO statement SEMICOLON statement WHILE expression OD

for_statement:		FOR ident set_equal expression DO statement ROF
			| FOR ident set_equal expression DO statement SEMICOLON statement ROF

compound_statement:	START statement STOP
			| START statement SEMICOLON statement STOP

expression:		term
			| term expression_op term

term:			id_num
			| id_num term_op id_num

id_num:			ident
			| number

%%
