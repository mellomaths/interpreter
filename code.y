%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "code.h"

#define YYDEBUG 1

void yyerror(const char *msg);
int yywrap();

extern int yylex();
%}

%define parse.lac full
%define parse.error verbose
%error-verbose

%union {
	int inteiro;
	float real;
	char *str;
	char *tipo;
}

%token <tipo> TIPO
%token <inteiro> NUMERO_INTEIRO
%token <real> NUMERO_REAL
%token <str> PALAVRA
%token <str> STRING;

%token MAIOR_IGUAL MENOR_IGUAL IGUAL DIFERENTE 
%token PONTO_VIRGULA ABRE_PARENTESES FECHA_PARENTESES
%token ESCREVE LE

%type <inteiro> EXPRESSAO

%%

DECLARACOES
	: DECLARACOES DECLARACAO
	| DECLARACAO
	;

EXPRESSAO 
	: NUMERO_INTEIRO 											{ $$ = $1; }						
	| EXPRESSAO '+' EXPRESSAO									{ $$ = $1 + $3; }
	| EXPRESSAO '-' EXPRESSAO									{ $$ = $1 - $3; }
	| EXPRESSAO '*' EXPRESSAO									{ $$ = $1 * $3; }
	| EXPRESSAO '/' EXPRESSAO									{ $$ = $1 / $3; }
	| EXPRESSAO '<' EXPRESSAO									{ $$ = $1 < $3; }
	| EXPRESSAO '>' EXPRESSAO									{ $$ = $1 > $3; }
	| EXPRESSAO MAIOR_IGUAL EXPRESSAO							{ $$ = $1 >= $3; }
	| EXPRESSAO MENOR_IGUAL EXPRESSAO							{ $$ = $1 <= $3; }
	| EXPRESSAO DIFERENTE EXPRESSAO								{ $$ = $1 != $3; }
	| EXPRESSAO IGUAL EXPRESSAO									{ $$ = $1 == $3; }
	| '(' EXPRESSAO ')'											{ $$ = $2; }
	| PALAVRA 													{ $$ = obtemValorDaVariavel($1); }
	;

FUNCOES 
	: ESCREVE EXPRESSAO											{ printf("%d\n", $2); }
	| LE PALAVRA												{ leEntradaDeDados($2); }
	;

DECLARACAO
	: TIPO PALAVRA 												{ limpaBuffers(); novaVariavel($2, $1, 0); }
	| TIPO PALAVRA '=' EXPRESSAO 								{ limpaBuffers(); novaVariavel($2, $1, $4); }
	| PALAVRA '=' EXPRESSAO										{ limpaBuffers(); alteraValorVariavel($1, $3); }
	| FUNCOES							
	;

%%

void yyerror(const char *msg) {
	fprintf(stderr, "Error: %s\n", msg);
	exit(1);
}

int yywrap(void) {
	return 1;
}

int main() {
	yyparse();
	return 0;
}
