%error-verbose

%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
int yyerror();
%}

/* Regular Expression Tokens */
%token ident number term_op expression_op

 /* Keyword Tokens */
%token PROGRAM TERMINATE
%token IMPL DECL DECLARATION END
%token TYPE VAR CONST ARR OF TO
%token FUNC PROC EXECUTE
%token FOR ROF DO OD WHILE ELIHW IF THEN FI
%token FOR_ASSIGN SET_ASSIGN IS
%token START STOP

/* Punctuation Tokens */
%token O_BRACE C_BRACE O_SBRACKET C_SBRACKET O_PAREN C_PAREN
%token PERIOD COMMA COLON SEMICOLON GREATER_THAN EQUALS

%start basic_program

%%

/*  Grammar Rules

    These rules define what is and isn't a valid PL-NEXT source file.
    If the text from the provided source file matches the basic_program
    rule, it is considered a syntactically valid PL-NEXT source code file. */

basic_program: 		PROGRAM declaration_unit implementation_unit TERMINATE

declaration_unit:	DECL COLON COLON ident DECLARATION END
			| DECL COLON COLON ident options DECLARATION END

options:                const_options
                        | var_options
                        | type_options
                        | proc_options
                        | function_interface

const_options:		CONST constant_declaration
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

formal_parameters:	O_PAREN multi_parameter C_PAREN

multi_parameter:	ident
			| multi_parameter SEMICOLON ident

type_declaration:	TYPE ident EQUALS GREATER_THAN type SEMICOLON

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

range_type:		O_SBRACKET range C_SBRACKET

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
