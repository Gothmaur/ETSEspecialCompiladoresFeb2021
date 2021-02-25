%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include "sintactico.tab.h"
%}
/*
Analizador Lexico
*/

L	[a-zA-Z_]
D	[0-9]

%%

"entero"        {yylval.valor = strdup(yytext);return INT;}
"decimal"       {yylval.valor = strdup(yytext);return FLOAT;}
"caracter"      {yylval.valor = strdup(yytext);return CHAR;}
"cadena"        {yylval.valor = strdup(yytext);return STRING;}

"constante"			{yylval.valor = strdup(yytext); return(CONST);}


"si"			       { yylval.valor = strdup(yytext); return(IF); }
"sino"			     { yylval.valor = strdup(yytext); return(ELSE); }
"cambiador"		   { yylval.valor = strdup(yytext); return(SWITCH); }
"caso"			     { yylval.valor = strdup(yytext); return(CASE); }
"romper"			   { yylval.valor = strdup(yytext); return(BREAK); }
"otro"		       { yylval.valor = strdup(yytext); return(DEFAULT); }

"por"			    { yylval.valor = strdup(yytext); return(FOR); }
"hacer"			  { yylval.valor = strdup(yytext); return(DO); }
"mientras"		{ yylval.valor = strdup(yytext); return(WHILE); }

"regresar"		{ yylval.valor = strdup(yytext); return(RETURN); }

"principal"		{	yylval.valor = strdup(yytext); return (MAIN);}

"+="			{ yylval.valor = strdup(yytext); return(ASIGNACION_SUM); }
"-="			{ yylval.valor = strdup(yytext); return(ASIGNACION_RES); }
"*="			{ yylval.valor = strdup(yytext); return(ASIGNACION_MUL); }
"/="			{ yylval.valor = strdup(yytext); return(ASIGNACION_DIV); }
"%="			{ yylval.valor = strdup(yytext); return(ASIGNACION_MOD); }

"++"			{ yylval.valor = strdup(yytext); return(OP_INC); }
"--"			{ yylval.valor = strdup(yytext); return(OP_DEC); }

"&&"			{ yylval.valor = strdup(yytext); return(OP_AND); }
"||"			{ yylval.valor = strdup(yytext); return(OP_OR); }
"<="			{ yylval.valor = strdup(yytext); return(OP_MENIG); }
">="			{ yylval.valor = strdup(yytext); return(OP_MAYIG); }
"=="			{ yylval.valor = strdup(yytext); return(OP_IGUAL); }
"!="			{ yylval.valor = strdup(yytext); return(OP_DIF); }

";"   				{ yylval.valor = strdup(yytext); return(';'); }
("{"|"<%")		{ yylval.valor = strdup(yytext); return('{'); }
("}"|"%>")		{ yylval.valor = strdup(yytext); return('}'); }
","		     		{ yylval.valor = strdup(yytext); return(','); }
":"				    { yylval.valor = strdup(yytext); return(':'); }
"="				    { yylval.valor = strdup(yytext); return('='); }
"("				    { yylval.valor = strdup(yytext); return('('); }
")"				    { yylval.valor = strdup(yytext); return(')'); }
("["|"<:")		{ yylval.valor = strdup(yytext); return('['); }
("]"|":>")		{ yylval.valor = strdup(yytext); return(']'); }
"."				    { yylval.valor = strdup(yytext); return('.'); }
"&"				    { yylval.valor = strdup(yytext); return('&'); }
"!"				    { yylval.valor = strdup(yytext); return('!'); }
"-"				    { yylval.valor = strdup(yytext); return('-'); }
"+"				    { yylval.valor = strdup(yytext); return('+'); }
"*"				    { yylval.valor = strdup(yytext); return('*'); }
"/"				    { yylval.valor = strdup(yytext); return('/'); }
"%"				    { yylval.valor = strdup(yytext); return('%'); }
"<"				    { yylval.valor = strdup(yytext); return('<'); }
">"				    { yylval.valor = strdup(yytext); return('>'); }
"^"				    { yylval.valor = strdup(yytext); return('^'); }
"|"				    { yylval.valor = strdup(yytext); return('|'); }
"?"				    { yylval.valor = strdup(yytext); return('?'); }

{L}({L}|{D})*	          { yylval.valor = strdup(yytext);return IDENTIFICADOR;}
("+"|"-")?{D}+	                  { yylval.valor = strdup(yytext); return ENTERO;}
("+"|"-")?{D}+"."{D}*             { yylval.valor = strdup(yytext); return DECIMAL;}
L?\"(\\.|[^\\"])*\"		  { yylval.valor = strdup(yytext); return(CADENA); }
L?'(\\.|[^\\'])'		    { yylval.valor = strdup(yytext); return(CARACTER); }


[ \t\v\n\f]		{ yylval.valor = strdup(yytext); }
.			{ /* ignorar otros caracteres */ }


%%
yywrap()
{
	return(1);
}
