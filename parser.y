%{
//Nico Williams and Brandon Rullamas
//nijowill and brullama
//Assignment 3 - LALR(1) Parser using bison

#include "lyutils.h"
#include <assert.h>
#include "astree.h"
%}

%debug
%defines
%error-verbose
%token-table

%token TOK_VOID TOK_BOOL TOK_CHAR TOK_INT TOK_STRING
%token TOK_IF TOK_ELSE TOK_WHILE TOK_RETURN TOK_STRUCT
%token TOK_FALSE TOK_TRUE TOK_NULL TOK_NEW TOK_ARRAY
%token TOK_EQ TOK_NE TOK_LT TOK_LE TOK_GT TOK_GE
%token TOK_IDENT TOK_INTCON TOK_CHARCON TOK_STRINGCON

%token TOK_BLOCK TOK_CALL TOK_IFELSE TOK_INITDECL
%token TOK_POS TOK_NEG TOK_NEWARRAY TOK_TYPEID TOK_FIELD

%right     TOK_IF TOK_ELSE
%right     '='
%left      TOK_EQ TOK_NE TOK_LT TOK_LE TOK_GT TOK_GE
%left      '+' '-'
%left      '*' '/' '%'
%right     TOK_POS TOK_NEG '!' TOK_ORD TOK_CHR
%left      '[' '.' TOK_CALL
%nonassoc  TOK_NEW
%nonassoc  '('

%start program

%%

program : program token | ;
token   : '(' | ')' | '[' | ']' | '{' | '}' | ';' | ',' | '.'
        | '=' | '+' | '-' | '*' | '/' | '%' | '!'
        | TOK_VOID | TOK_BOOL | TOK_CHAR | TOK_INT | TOK_STRING
        | TOK_IF | TOK_ELSE | TOK_WHILE | TOK_RETURN | TOK_STRUCT
        | TOK_FALSE | TOK_TRUE | TOK_NULL | TOK_NEW | TOK_ARRAY
        | TOK_EQ | TOK_NE | TOK_LT | TOK_LE | TOK_GT | TOK_GE
        | TOK_IDENT | TOK_INTCON | TOK_CHARCON | TOK_STRINGCON
        ;

expr	: expr '=' expr			{ $$ = adopt2($2, $1, $3); }
		| expr TOK_EQ expr		{ $$ = adopt2($2, $1, $3); }
		| expr TOK_NE expr		{ $$ = adopt2($2, $1, $3); }
		| expr TOK_LT expr		{ $$ = adopt2($2, $1, $3); }
		| expr TOK_LE expr		{ $$ = adopt2($2, $1, $3); }
		| expr TOK_GT expr		{ $$ = adopt2($2, $1, $3); }
		| expr TOK_GE expr		{ $$ = adopt2($2, $1, $3); }
		| expr '+' expr			{ $$ = adopt2($2, $1, $3); }
		| expr '-' expr			{ $$ = adopt2($2, $1, $3); }
		| expr '*' expr			{ $$ = adopt2($2, $1, $3); }
		| expr '/' expr			{ $$ = adopt2($2, $1, $3); }
		| expr '%' expr			{ $$ = adopt2($2, $1, $3); }
		| '+' expr %prec TOK_POS {$1 -> symbol = TOK_POS;
								  $$ = adopt1($1, $2);
								  }
        | '-' expr %prec TOK_POS {$1 -> symbol = TOK_NEG;
								  $$ = adopt1($1, $2);
								  }
		;
		
		
		
%%

const char *get_yytname (int symbol) {
   return yytname [YYTRANSLATE (symbol)];
}
