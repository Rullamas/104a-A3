%{

//Nico Williams and Brandon Rullamas
//nijowill and brullama
//Assignment 2 - Lexical Analyzer using flex

#include <stdlib.h>
#include <stdbool.h>
#include "auxlib.h"
#include "lyutils.h"

#define YY_USER_ACTION 	{ scanner_useraction (); }
#define YY_USER_INIT 	{scanner_userinit (); }
#define IGNORE(THING) 	{ }

%}

%option 8bit
%option backup
%option debug
%option ecs
%option nodefault
%option nounput
%option noyywrap
%option perf-report
%option verbose

LETTER          [A-Za-z_]
DIGIT           [0-9]
MANTISSA        ({DIGIT}+\.?{DIGIT}*|\.{DIGIT}+)
EXPONENT        ([Ee][+-]?{DIGIT}+)
NUMBER          ({MANTISSA}{EXPONENT}?)
NOTNUMBER       ({MANTISSA}[Ee][+-]?)
TOK_IDENT       ({LETTER}({LETTER}|{DIGIT})*)
TOK_STRINGCON	(\"([^\\"\n]|\\[\\'"0nt])*\")
TOK_CHARCON		('([^\\'\n]|\\[\\'"0nt])')

%%

"#".*           { scanner_include(); }
[ \t]+          { }
\n              { scanner_newline(); }

{NUMBER}        { return yylval_token (NUMBER); }
{TOK_IDENT}     { return yylval_token (TOK_IDENT); }

"="             { return yylval_token ('='); }
"+"             { return yylval_token ('+'); }
"-"             { return yylval_token ('-'); }
"*"             { return yylval_token ('*'); }
"/"             { return yylval_token ('/'); }
"^"             { return yylval_token ('^'); }
"("             { return yylval_token ('('); }
")"             { return yylval_token (')'); }
";"             { return yylval_token (';'); }

{NOTNUMBER}     { scanner_badtoken (yytext);
                  return yylval_token (TOK_INT); }

.               { scanner_badchar (*yytext); }

%%