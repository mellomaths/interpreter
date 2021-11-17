%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "code.tab.h" // generado atraves do comando "bison -d code.y"

void tokenInvalido();
%}

espacos      			[ \t\r\v\f]
quebradelinha        	\n

%%

"inteiro"  |
"real"                                  { yylval.tipo = strdup(yytext); return TIPO; }

"escreve"								{ return ESCREVE; }
"le"                                    { return LE; }

"("										{ return ABRE_PARENTESES; }
")"										{ return FECHA_PARENTESES; }

";"                                     { return PONTO_VIRGULA; }
">="									{ return MAIOR_IGUAL; }
"<="									{ return MENOR_IGUAL; }
"=="									{ return IGUAL; }
"!="									{ return DIFERENTE; }

[0-9][0-9]* 							{ yylval.inteiro = atoi(yytext); return NUMERO_INTEIRO; }
[0-9][0-9]*\.[0-9][0-9]* 				{ yylval.real = atof(yytext); return NUMERO_REAL; }
[a-zA-Z][a-zA-Z0-9]* 					{ yylval.str = strdup(yytext);  return PALAVRA; }
\"(\\.|[^"])*\"                         { yylval.str = strdup(yytext); return STRING; }

{quebradelinha}                         { yylineno++; }
{espacos}                            	;

[-()<>=+*/;{}.] 						{ return *yytext; }
.                                       { tokenInvalido(); }

%%

void tokenInvalido() {
    fprintf(stderr, "Erro na linha %d : \n Token invalido %s\n", yylineno, yytext);
    exit(1);
}


