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
%type <valor> Tipo
%type <valor> Codigo
%type <valor> Linea
%type <valor> Declaraciones
%type <valor> DeclararVariable
%type <valor> DeclararConstante
%type <valor> Asignaciones
%type <valor> Suma
%type <valor> Producto
%type <valor> expresion_cast
%type <valor> expresion_unaria
%type <valor> expresion_postfija
%type <valor> expresion_numerica
%type <valor> expresion_alfanumerica
%type <valor> Lista_Argumentos
%type <valor> Encadenar

%start Funcion
%%

Funcion
  : IDENTIFICADOR Contenido                             { printf("Se declara funcion %s\nContiene lo siguiente:\n%s",$1,$2);}
  | IDENTIFICADOR '(' Lista_atributos ')' Contenido     { printf("Se declara funcion %s\nContiene los siguientes atributos: %s\nContiene lo siguiente:\n%s",$1,$3,$5);}
  | MAIN Contenido                                      { printf("Se declara funcion %s\nContiene lo siguiente:\n%s",$1,$2);}
  | MAIN '(' Lista_atributos ')' Contenido              { printf("Se declara funcion %s\nContiene los siguientes atributos: %s\nContiene lo siguiente: \n%s",$1,$3,$5);}
;

Lista_atributos
  : Atributo                      {$$=$1;}
  | Lista_atributos ',' Atributo  {strcat($1,$3);$$=$1;}
;

Atributo
  : Tipo IDENTIFICADOR        { char *tmp=strdup($1);strcpy($1,"\n\t* variable: ");strcat($1,tmp);strcat($1,$2);$$=$1;}
  ;

Tipo
	: CHAR 		{$$=$1;}
	| INT 		{$$=$1;}
	| FLOAT 	{$$=$1;}
	| STRING 		{$$=$1;}
	;

Contenido
  : '{' '}'             {printf("\nVacio");}
  | '{' Codigo '}'      {$$=$2;}
  ;

Codigo
  : Linea           {$$=$1;}
  | Codigo Linea    {strcat($1,$2);$$=$1;}
  ;

Linea
  : Declaraciones    {$$=$1;}
  | Asignaciones      {$$=$1;}
  ;

Declaraciones
  :DeclararVariable       {$$=$1;}
  |DeclararConstante      {$$=$1;}
  ;

DeclararVariable
  : Atributo '=' expresion_numerica ';'       {char *tmp=strdup($1);strcpy($1,"\n\t* Declaracion de variable numerica: ");strcat($1,tmp); strcat($1,$2);strcat($1,$3);strcat($1,$4);$$=$1;}
  | Atributo '=' expresion_alfanumerica ';'       {char *tmp=strdup($1);strcpy($1,"\n\t* Declaracion de variable alfanumerica: ");strcat($1,tmp); strcat($1,$2);strcat($1,$3);strcat($1,$4);$$=$1;}
  | Atributo ';'                              {$$ = $1;}
  ;


DeclararConstante
  : CONST CHAR IDENTIFICADOR '=' CARACTER ';'       {char *tmp=strdup($1);strcpy($1,"\n\t* Declaracion de constante caracter: ");strcat($1,tmp); strcat($1,$2);strcat($1,$3);strcat($1,$4);strcat($1,$5);$$=$1;}
  | CONST INT IDENTIFICADOR '=' ENTERO ';'          {char *tmp=strdup($1);strcpy($1,"\n\t* Declaracion de constante entero: ");strcat($1,tmp); strcat($1,$2);strcat($1,$3);strcat($1,$4);strcat($1,$5);$$=$1;}
  | CONST FLOAT IDENTIFICADOR '=' DECIMAL ';'       {char *tmp=strdup($1);strcpy($1,"\n\t* Declaracion de constante decimal: ");strcat($1,tmp); strcat($1,$2);strcat($1,$3);strcat($1,$4);strcat($1,$5);$$=$1;}
  | CONST STRING IDENTIFICADOR '=' CADENA ';'       {char *tmp=strdup($1);strcpy($1,"\n\t* Declaracion de constante cadena: ");strcat($1,tmp); strcat($1,$2);strcat($1,$3);strcat($1,$4);strcat($1,$5);$$=$1;}
  ;

Asignaciones
  :IDENTIFICADOR '=' Suma    {strcat($1,$2);strcat($1,$3);$$=$1;}
  |IDENTIFICADOR '=' Encadenar      {strcat($1,$2);strcat($1,$3);$$=$1;}
  |IDENTIFICADOR ASIGNACION_SUM expresion_numerica  {strcat($1,$2);strcat($1,$3);$$=$1;}
  ;



Suma
  : Producto            {$$=$1;}
  | Suma '+' Producto 	{strcat($1," + ");strcat($1,$3);$$=$1;}
  | Suma '-' Producto 	    {strcat($1," - ");strcat($1,$3);$$=$1;}
  ;

Producto
  : expresion_cast               	{$$=$1;}
  | Producto '*' expresion_cast 	{strcat($1," * ");strcat($1,$3);$$=$1;}
  | Producto '/' expresion_cast 	{strcat($1," / ");strcat($1,$3);$$=$1;}
  | Producto '%' expresion_cast 	{strcat($1," % ");strcat($1,$3);$$=$1;}
  ;

expresion_cast
  : expresion_unaria            {$$=$1;}
  | '(' Tipo ')' expresion_cast {strcat($1,$2);strcat($1,$3);strcat($1,$4);$$=$1;}
  ;

  expresion_unaria
	: expresion_postfija	             {$$ = $1;}
	| OP_INC expresion_unaria	         {strcat($1," ");strcat($1,$2);$$=$1;}
	| OP_DEC expresion_unaria	         {strcat($1," ");strcat($1,$2);$$=$1;}
	;

expresion_postfija
	: expresion_numerica                                        {$$ = $1;}
  | IDENTIFICADOR                                             {$$ = $1;}
	| expresion_postfija '(' ')' 			                          {strcat($1,"()");$$ = $1;}
	| expresion_postfija '(' Lista_Argumentos ')'	             	{strcat($1,"(");strcat($1,$3);strcat($1,")");$$=$1;}
	| expresion_postfija OP_INC	                                {strcat($1," ");strcat($1,$2);$$=$1;}
	| expresion_postfija OP_DEC	                                {strcat($1," ");strcat($1,$2);$$=$1;}
	;

  expresion_numerica
  	: ENTERO 	             {$$ = $1;}
  	| DECIMAL              {$$ = $1;}
  	;

  expresion_alfanumerica
    : CADENA    {$$=$1;}
    | CARACTER  {$$=$1;}
    ;

  Lista_Argumentos
    :expresion_postfija                        {$$=$1;}
    |Lista_Argumentos ',' expresion_postfija    {strcat($1,$2);strcat($1,$3);$$=$1;}
    ;

Encadenar
  : expresion_alfanumerica                {$$=$1;}
  | Encadenar '.' expresion_alfanumerica  {$$=$1;}
  ;

%%
