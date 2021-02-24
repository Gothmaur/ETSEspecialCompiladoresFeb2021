%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>

	void yyerror(char *mensaje){
		printf("ERROR: %s\n", mensaje);
		exit(0);
	}
%}

%union
{
	char *valor;
}

%token <valor> CHAR INT FLOAT STRING CONST VOID

%token <valor> IDENTIFICADOR ENTERO DECIMAL CADENA CARACTER

%token <valor> IF ELSE SWITCH CASE BREAK DEFAULT WHILE DO FOR RETURN

%token <valor> ASIGNACION_SUM ASIGNACION_RES ASIGNACION_MUL ASIGNACION_DIV ASIGNACION_MOD

%token <valor> OP_INC OP_DEC

%token <valor> OP_AND OP_OR OP_MENIG OP_MAYIG OP_IGUAL OP_DIF

%token <valor>  ';' '{' '}' ',' ':' '=' '(' ')' '[' ']'
%token <valor> '.' '&' '!' '-' '+' '*' '/' '%' '<' '>' '^' '|' '?'

%type <valor> Funcion
%type <valor> Tipo
%type <valor> Contenido
%type <valor> Lista_atributos
%type <valor> Atributo
%type <valor> Codigo
%type <valor> Linea
%type <valor> Declaraciones



%start unidad_traduccion
%%

Funcion
  : IDENTIFICADOR '(' ')' Contenido                     { printf("Se declara funcion %s\nContiene lo siguiente:\n%s",$1,$4);}
  | IDENTIFICADOR '(' Lista_atributos ')' Contenido     { printf("Se declara funcion %s\nContiene los siguientes atributos: %s\nContiene lo siguiente:\n%s",$1,$3,$5);}
  | "principal" '(' ')' Contenido                       { printf("Se declara funcion %s\nContiene lo siguiente:\n%s",$1,$4);}
  | "principal" '(' Lista_atributos ')' Contenido       { printf("Se declara funcion %s\nContiene los siguientes atributos: %s\nContiene lo siguiente: \n%s",$1,$3,$5);}
;

Lista_atributos
  : Atributo                      {$$=$1}
  | Lista_atributos ',' Atributo  {strcat($1,$3);$$=$1}
;

Atributo : Tipo IDENTIFICADOR     { char *tmp=strdup($1);strcpy($1,"\n\t* Atributo: tipo ");strcat($1,tmp); strcpy(tmp," de nombre ");strcat($1,tmp);strcat($1,$2);$$=$1;};

Tipo
  : INT       {$$="entero";}
  | FLOAT     {$$="decimal";}
  | STRING    {$$="cadena";}
  | CHAR      {$$="caracter";}
;

Contenido
  : '{' Codigo '}' {$$=$2;}
  ;

Codigo
  : Linea           {$$=$1;}
  | Codigo Linea    {strcat($1,$2);$$=$1;}
  ;

Linea
  : "\n"                  {$$=$1;}
  | Declaraciones "\n"    {$$=$1;}
  ;
