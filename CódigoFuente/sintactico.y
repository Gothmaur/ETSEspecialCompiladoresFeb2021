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



%token <valor> MAIN IDENTIFICADOR ENTERO DECIMAL CADENA CARACTER
%token <valor> OP_INC OP_DEC OP_MENIG OP_MAYIG OP_IGUAL OP_DIF
%token <valor> OP_AND OP_OR
%token <valor> ASIGNACION_MUL ASIGNACION_DIV ASIGNACION_MOD ASIGNACION_SUM ASIGNACION_RES
%token <valor>  ';' '{' '}' ',' ':' '=' '(' ')' '[' ']'
%token <valor> '.' '&' '!' '-' '+' '*' '/' '%' '<' '>' '^' '|' '?'
%token <valor> CHAR INT FLOAT STRING CONST
%token <valor> CASE DEFAULT IF ELSE SWITCH WHILE DO FOR BREAK RETURN

%type <valor> Contenido
%type <valor> Lista_atributos
%type <valor> Atributo
%type <valor> Codigo
%type <valor> Linea
%type <valor> Declaraciones
%type <valor> DeclararVariable
%type <valor> DeclararConstante

%start Funcion
%%

Funcion
  : IDENTIFICADOR '(' ')' Contenido                     { printf("Se declara funcion %s\nContiene lo siguiente:\n%s",$1,$4);}
  | IDENTIFICADOR '(' Lista_atributos ')' Contenido     { printf("Se declara funcion %s\nContiene los siguientes atributos: %s\nContiene lo siguiente:\n%s",$1,$3,$5);}
  | MAIN '(' ')' Contenido                              { printf("Se declara funcion %s\nContiene lo siguiente:\n%s",$1,$4);}
  | MAIN '(' Lista_atributos ')' Contenido              { printf("Se declara funcion %s\nContiene los siguientes atributos: %s\nContiene lo siguiente: \n%s",$1,$3,$5);}
;

Lista_atributos
  : Atributo                      {$$=$1;}
  | Lista_atributos ',' Atributo  {strcat($1,$3);$$=$1;}
;

Atributo : Tipo IDENTIFICADOR     { char *tmp=strdup($1);strcpy($1,"\n\t* Atributo: ");strcat($1,tmp);strcat($1,$2);$$=$1;};

Contenido : '{' Codigo '}' {$$=$2;};

Codigo
  : Linea           {$$=$1;}
  | Codigo Linea    {strcat($1,$2);$$=$1;}
  ;

Linea
  : Declaraciones    {$$=$1;}
  ;

Declaraciones
  :DeclararVariable       {$$=$1;}
  |DeclararConstante      {$$=$1;}
  ;

DeclararVariable
  : CHAR IDENTIFICADOR '=' CARACTER ';'       {char *tmp=strdup($1);strcpy($1,"\n\t* Declaracion de variable caracter: ");strcat($1,tmp); strcat($1,$2);strcat($1,$3);strcat($1,$4);$$=$1;}
  | INT IDENTIFICADOR '=' ENTERO ';'          {char *tmp=strdup($1);strcpy($1,"\n\t* Declaracion de variable entero: ");strcat($1,tmp); strcat($1,$2);strcat($1,$3);strcat($1,$4);$$=$1;}
  | FLOAT IDENTIFICADOR '=' DECIMAL ';'       {char *tmp=strdup($1);strcpy($1,"\n\t* Declaracion de variable decimal: ");strcat($1,tmp); strcat($1,$2);strcat($1,$3);strcat($1,$4);$$=$1;}
  | STRING IDENTIFICADOR '=' CADENA ';'       {char *tmp=strdup($1);strcpy($1,"\n\t* Declaracion de variable cadena: ");strcat($1,tmp); strcat($1,$2);strcat($1,$3);strcat($1,$4);$$=$1;}
  | CHAR IDENTIFICADOR ';'                    {char *tmp=strdup($1);strcpy($1,"\n\t* Declaracion de variable caracter: ");strcat($1,tmp); strcat($1,$2);$$=$1;}
  | INT IDENTIFICADOR ';'                     {char *tmp=strdup($1);strcpy($1,"\n\t* Declaracion de variable entero: ");strcat($1,tmp); strcat($1,$2);$$=$1;}
  | FLOAT IDENTIFICADOR ';'                   {char *tmp=strdup($1);strcpy($1,"\n\t* Declaracion de variable decimal: ");strcat($1,tmp); strcat($1,$2);$$=$1;}
  | STRING IDENTIFICADOR ';'                  {char *tmp=strdup($1);strcpy($1,"\n\t* Declaracion de variable cadena: ");strcat($1,tmp); strcat($1,$2);$$=$1;}
  ;


  DeclararConstante
    : CONST CHAR IDENTIFICADOR '=' CARACTER ';'       {char *tmp=strdup($1);strcpy($1,"\n\t* Declaracion de constante caracter: ");strcat($1,tmp); strcat($1,$2);strcat($1,$3);strcat($1,$4);strcat($1,$5);$$=$1;}
    | CONST INT IDENTIFICADOR '=' ENTERO ';'          {char *tmp=strdup($1);strcpy($1,"\n\t* Declaracion de constante entero: ");strcat($1,tmp); strcat($1,$2);strcat($1,$3);strcat($1,$4);strcat($1,$5);$$=$1;}
    | CONST FLOAT IDENTIFICADOR '=' DECIMAL ';'       {char *tmp=strdup($1);strcpy($1,"\n\t* Declaracion de constante decimal: ");strcat($1,tmp); strcat($1,$2);strcat($1,$3);strcat($1,$4);strcat($1,$5);$$=$1;}
    | CONST STRING IDENTIFICADOR '=' CADENA ';'       {char *tmp=strdup($1);strcpy($1,"\n\t* Declaracion de constante cadena: ");strcat($1,tmp); strcat($1,$2);strcat($1,$3);strcat($1,$4);strcat($1,$5);$$=$1;}
    ;
