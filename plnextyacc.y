%error-verbose
%locations

%{
#include <stdio.h>
#include <stdlib.h>
#define YYSTYPE char*
int yywrap();
int yylex();
int yyerror();
%}

%union {
	char *s;
}

/* Regular Expression Tokens */
%token ident number term_op expression_op

 /* General Keywords */
%token START STOP TO PROGRAM TERMINATE OF

/* Type Keywords */
%token TYPE VAR CONST ARR

 /* Control Structure Keywords */
%token FOR ROF DO OD WHILE ELIHW IF THEN FI

/* Assignments */
%token FOR_ASSIGN SET_ASSIGN IS

/* Function Keywords */
%token FUNC PROC EXECUTE

/* Unit Keywords */
%token IMPL DECL DECLARATION END

/* Punctuation */
%token O_BRACE C_BRACE O_HBRACKET C_HBRACKET O_BRACKET C_BRACKET
%token PERIOD COMMA COLON SEMICOLON GREATERTHAN EQUALS

%start input

%%

input: 			basic_program { printf("Test success!\n"); }

basic_program: 		PROGRAM declaration_unit implementation_unit TERMINATE

declaration_unit:	DECL COLON COLON ident DECLARATION END
			| DECL COLON COLON ident decl_options DECLARATION END

decl_options:		CONST constant_declaration
	     		| CONST constant_declaration var_options
			| CONST constant_declaration type_options
			| CONST constant_declaration proc_options
			| CONST constant_declaration function_interface

var_options:		VAR variable_declaration
	   		| VAR variable_declaration type_options
			| VAR variable_declaration proc_options
			| VAR variable_declaration function_interface

type_options:		type_declaration
	    		| type_declaration proc_options
			| type_declaration function_interface

proc_options:		procedure_interface
	    		| procedure_interface function_interface

procedure_interface:	PROC ident
		   	| PROC ident formal_parameters

function_interface:	FUNC ident
		  	| FUNC ident formal_parameters

type_declaration:	TYPE ident EQUALS GREATERTHAN type SEMICOLON

formal_parameters:	O_BRACKET multi_parameter C_BRACKET

multi_parameter:	ident
			| multi_parameter SEMICOLON ident

constant_declaration:	constant SEMICOLON

constant:		ident IS number
			| constant COMMA ident IS number

variable_declaration:	variable SEMICOLON

variable:		ident COLON ident
			| variable COMMA ident COLON ident

type:			basic_type
    			| array_type

basic_type:		ident
	  		| enumerated_type
			| range_type

enumerated_type:	O_BRACE enum_element C_BRACE

enum_element:		ident
			| enum_element COMMA ident

range_type:		O_HBRACKET range C_HBRACKET

array_type:		ARR ident range_type OF type

range:			number TO number

implementation_unit:	IMPL COLON COLON ident block PERIOD

block:			specification_part implementation_part

specification_part:	CONST constant_declaration
		  	| VAR variable_declaration
			| procedure_declaration
			| function_declaration
			| ;

procedure_declaration:	PROC ident SEMICOLON block SEMICOLON

function_declaration:	FUNC ident SEMICOLON block SEMICOLON

implementation_part:	statement

statement:		assignment
			| procedure_call
			| if_statement
			| while_statement
			| do_statement
			| for_statement 
			| compound_statement

assignment:		ident SET_ASSIGN expression

procedure_call:		EXECUTE ident

if_statement:		IF expression THEN statement FI

while_statement:	WHILE expression DO multi_statement ELIHW

do_statement:		DO multi_statement WHILE expression OD

for_statement:		FOR ident COLON EQUALS expression DO multi_statement ROF

compound_statement:	START multi_statement STOP

multi_statement:	statement
			| multi_statement SEMICOLON statement

expression:		term
			| expression expression_op term

term:			id_num
			| term term_op id_num

id_num:			ident
			| number

%%
