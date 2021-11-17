#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char TIPO_DE_DADO[50];

int totalDeVariaveis = 0;

struct Variavel {
    char *identificador;
    int valor;
    char *tipo;
} variaveis[20];


void limpaBuffers() {
    int i = 0;
    while (TIPO_DE_DADO[i] != '\0') {
        TIPO_DE_DADO[i] = '\0';
        i++;
    }
}


void salvaTipo(char *tipo) {
    int i = 0;
    while (tipo[i] != '\0') {
        TIPO_DE_DADO[i] = tipo[i];
        i++;
    }
}

char* getTipoDeDado() {
    return TIPO_DE_DADO;
}


int variavelDuplicada(char* identificador) {
    for (int i = 0; i < totalDeVariaveis; i++) {
        if (strcmp(identificador, variaveis[i].identificador) == 0) {
            return 1;
        }
    }

    return 0;
}

void VariavelDuplicadaException(char* identificador) {
    fprintf(stderr, "Identificador de variavel duplicado '%s'\n", identificador);
    exit(1);
}

void VariavelInexistenteException(char* identificador) {
    fprintf(stderr, "Identificador de variavel inexistente '%s'\n", identificador);
    exit(1);
}

int obtemValorDaVariavel(char *identificador) {
    for (int i = 0; i < totalDeVariaveis; i++) {
        if (strcmp(identificador, variaveis[i].identificador) == 0) {
            return variaveis[i].valor;
        }
    }

    VariavelInexistenteException(identificador);
    return 0;
}

void novaVariavel(char* identificador, char* tipo, int valor) {
    if (variavelDuplicada(identificador)) {
        VariavelDuplicadaException(identificador);
    }

    salvaTipo(tipo);
    variaveis[totalDeVariaveis].identificador = identificador;
    variaveis[totalDeVariaveis].tipo = getTipoDeDado();
    variaveis[totalDeVariaveis].valor = valor;
    totalDeVariaveis++;
}

void alteraValorVariavel(char* identificador, int valor) {
    int encontrou = 0;
    for (int i = 0; i < totalDeVariaveis; i++) {
        if (strcmp(identificador, variaveis[i].identificador) == 0) {
            variaveis[i].valor = valor;
            encontrou = 1;
        }
    }

    if (encontrou == 0) {
        VariavelInexistenteException(identificador);
    }
}

void leEntradaDeDados(char* identificador) {
    int novoValor;
    scanf("%d", &novoValor);
    alteraValorVariavel(identificador, novoValor);
}