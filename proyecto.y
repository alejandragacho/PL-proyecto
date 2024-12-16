%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
extern int yylex();
extern int yylineno;

/* Declaración de funciones auxiliares */
char* describe(char* elemento, int numero);
char* concat(const char* str1, const char* str2, const char* str3);
char* prefijo(int numero);
char* nombre_trivial(const char* compuesto);

%}

%define parse.error verbose

%union {
    char* str;
    int num;
}
%token <str> ELEMENTO
%token <num> SUBINDICE
%token SALTO
%type <str> secuencia_elementos compuesto
%start S
%%

S:
    fichero { printf("Fin \n"); return 0;}
;

fichero:
    formula
    | formula SALTO fichero
;

formula:
    compuesto {
        printf("Procesando fórmula: %s\n", $1);
        free($1); // Liberar memoria asignada dinámicamente
    }
;

compuesto:
    secuencia_elementos {
        $$ = $1; // La salida del compuesto es igual a secuencia_elementos
    }
;

secuencia_elementos:
    ELEMENTO SUBINDICE secuencia_elementos {
        printf("Elemento: %s, Subíndice: %d, Resto: %s\n", $1, $2, $3 ? $3 : "NULL");
        char compuesto[200];
        sprintf(compuesto, "%s%d%s", $1, $2, $3 ? $3 : ""); // Construir la fórmula completa
        char* nombre_comun = nombre_trivial(compuesto);
        if (nombre_comun) {
            $$ = strdup(nombre_comun); // Usar el nombre trivial si existe
        } else {
            $$ = strdup(compuesto); // Retornar el compuesto construido si no hay nombre trivial
        }
    }
    | ELEMENTO SUBINDICE {
        printf("Elemento: %s, Subíndice: %d\n", $1, $2);
        char compuesto[50];
        sprintf(compuesto, "%s%d", $1, $2); // Construir la fórmula parcial
        char* nombre_comun = nombre_trivial(compuesto);
        if (nombre_comun) {
            $$ = strdup(nombre_comun);
        } else {
            $$ = strdup(compuesto);
        }
    }
    | ELEMENTO {
        printf("Elemento: %s\n", $1);
        $$ = strdup($1); // Retornar el elemento como string
    }
;







%%

char* get_componente(char* simbolo) {
    if (strcmp(simbolo, "H") == 0) return("Hidrógeno ");
    else if (strcmp(simbolo, "He") == 0) return("Helio ");
    else if (strcmp(simbolo, "Li") == 0) return("Litio ");
    else if (strcmp(simbolo, "Be") == 0) return("Berilio ");
    else if (strcmp(simbolo, "B") == 0) return("Boro ");
    else if (strcmp(simbolo, "C") == 0) return("Carbono ");
    else if (strcmp(simbolo, "N") == 0) return("Nitrógeno ");
    else if (strcmp(simbolo, "O") == 0) return("Oxígeno ");
    else if (strcmp(simbolo, "F") == 0) return("Flúor ");
    else if (strcmp(simbolo, "Ne") == 0) return("Neón ");
    else if (strcmp(simbolo, "Na") == 0) return("Sodio ");
    else if (strcmp(simbolo, "Mg") == 0) return("Magnesio ");
    else if (strcmp(simbolo, "Al") == 0) return("Aluminio ");
    else if (strcmp(simbolo, "Si") == 0) return("Silicio ");
    else if (strcmp(simbolo, "P") == 0) return("Fósforo ");
    else if (strcmp(simbolo, "S") == 0) return("Azufre ");
    else if (strcmp(simbolo, "Cl") == 0) return("Cloro ");
    else if (strcmp(simbolo, "Ar") == 0) return("Argón ");
    else if (strcmp(simbolo, "K") == 0) return("Potasio ");
    else if (strcmp(simbolo, "Ca") == 0) return("Calcio ");
    else if (strcmp(simbolo, "Sc") == 0) return("Escandio ");
    else if (strcmp(simbolo, "Ti") == 0) return("Titanio ");
    else if (strcmp(simbolo, "V") == 0) return("Vanadio ");
    else if (strcmp(simbolo, "Cr") == 0) return("Cromo ");
    else if (strcmp(simbolo, "Mn") == 0) return("Manganeso ");
    else if (strcmp(simbolo, "Fe") == 0) return("Hierro ");
    else if (strcmp(simbolo, "Co") == 0) return("Cobalto ");
    else if (strcmp(simbolo, "Ni") == 0) return("Níquel ");
    else if (strcmp(simbolo, "Cu") == 0) return("Cobre ");
    else if (strcmp(simbolo, "Zn") == 0) return("Zinc ");
    else if (strcmp(simbolo, "Ga") == 0) return("Galio ");
    else if (strcmp(simbolo, "Ge") == 0) return("Germanio ");
    else if (strcmp(simbolo, "As") == 0) return("Arsénico ");
    else if (strcmp(simbolo, "Se") == 0) return("Selenio ");
    else if (strcmp(simbolo, "Br") == 0) return("Bromo ");
    else if (strcmp(simbolo, "Kr") == 0) return("Kriptón ");
    else if (strcmp(simbolo, "Rb") == 0) return("Rubidio ");
    else if (strcmp(simbolo, "Sr") == 0) return("Estroncio ");
    else if (strcmp(simbolo, "Y") == 0) return("Itrio ");
    else if (strcmp(simbolo, "Zr") == 0) return("Circonio ");
    else if (strcmp(simbolo, "Mo") == 0) return("Molibdeno ");
    else if (strcmp(simbolo, "Pd") == 0) return("Paladio ");
    else if (strcmp(simbolo, "Ag") == 0) return("Plata ");
    else if (strcmp(simbolo, "Cd") == 0) return("Cadmio ");
    else if (strcmp(simbolo, "Sn") == 0) return("Estaño ");
    else if (strcmp(simbolo, "I") == 0) return("Yodo ");
    else if (strcmp(simbolo, "Xe") == 0) return("Xenón ");
    else if (strcmp(simbolo, "Cs") == 0) return("Cesio ");
    else if (strcmp(simbolo, "Ba") == 0) return("Bario ");
    else if (strcmp(simbolo, "Pt") == 0) return("Platino ");
    else return("%s ", simbolo);

}

char* nombre_trivial(const char* compuesto) {
    printf("Buscando nombre trivial para: %s\n", compuesto);
    if (strcmp(compuesto, "H2O") == 0) return "Agua";
    if (strcmp(compuesto, "CO2") == 0) return "Dióxido de carbono";
    if (strcmp(compuesto, "NH3") == 0) return "Amoníaco";
    if (strcmp(compuesto, "CH4") == 0) return "Metano";
    if (strcmp(compuesto, "C2H6") == 0) return "Etano";
    if (strcmp(compuesto, "C3H8") == 0) return "Propano";
    if (strcmp(compuesto, "C4H10") == 0) return "Butano";
    return NULL; // Si no hay un nombre común, devuelve NULL
}




char* describe(char* componente, int numero) {
    char compuesto[50];
    if (numero > 1) {
        sprintf(compuesto, "%s%d", componente, numero); // Ejemplo: H2
    } else {
        strcpy(compuesto, componente); // Ejemplo: H
    }

    char* nombre_comun = nombre_trivial(compuesto);
    if (nombre_comun) {
        return strdup(nombre_comun); // Devuelve el nombre trivial si existe
    }

    char* resultado = (char*)malloc(200);
    char* elemento = get_componente(componente);
    const char* pref = prefijo(numero);
    if (numero > 1) {
        sprintf(resultado, "%s%s", pref, elemento);
    } else {
        sprintf(resultado, "%s", elemento);
    }
    return resultado;
}



/* Función para generar prefijos numéricos en texto */
char* prefijo(int numero) {
    switch (numero) {
        case 1: return "Mono";
        case 2: return "Di";
        case 3: return "Tri";
        case 4: return "Tetra";
        case 5: return "Penta";
        case 6: return "Hexa";
        case 7: return "Hepta";
        case 8: return "Octa";
        case 9: return "Nona";
        case 10: return "Deca";
        default: return ""; // Para números fuera del rango
    }
}

/* Función auxiliar para concatenar cadenas */
char* concat(const char* str1, const char* str2, const char* str3) {
    char* resultado = (char*)malloc(strlen(str1) + strlen(str2) + strlen(str3) + 1);
    strcpy(resultado, str1);
    strcat(resultado, str2);
    strcat(resultado, str3);
    return resultado;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}