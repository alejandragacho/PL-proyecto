%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* simbolo;
    int cantidad;
} Componente;

%}

%union {
    char* str;
    int num;
    Componente componente;
}

%token <str> ELEMENTO
%token <num> SUBINDICE
%type <componente> compuesto

%%

// Gramática de la fórmula química
formula:
    compuesto { imprimir_componente($1); }
    | compuesto formula { imprimir_componente($1); }
    ;

compuesto:
    ELEMENTO SUBINDICE { $$ = (Componente){ $1, $2 }; }
    | ELEMENTO         { $$ = (Componente){ $1, 1 }; }
    ;

%%

// Función para traducir los elementos a texto explicativo
void imprimir_componente(Componente componente) {
    if (strcmp(componente.simbolo, "H") == 0) printf("Hidrógeno ");
    else if (strcmp(componente.simbolo, "He") == 0) printf("Helio ");
    else if (strcmp(componente.simbolo, "Li") == 0) printf("Litio ");
    else if (strcmp(componente.simbolo, "Be") == 0) printf("Berilio ");
    else if (strcmp(componente.simbolo, "B") == 0) printf("Boro ");
    else if (strcmp(componente.simbolo, "C") == 0) printf("Carbono ");
    else if (strcmp(componente.simbolo, "N") == 0) printf("Nitrógeno ");
    else if (strcmp(componente.simbolo, "O") == 0) printf("Oxígeno ");
    else if (strcmp(componente.simbolo, "F") == 0) printf("Flúor ");
    else if (strcmp(componente.simbolo, "Ne") == 0) printf("Neón ");
    else if (strcmp(componente.simbolo, "Na") == 0) printf("Sodio ");
    else if (strcmp(componente.simbolo, "Mg") == 0) printf("Magnesio ");
    else if (strcmp(componente.simbolo, "Al") == 0) printf("Aluminio ");
    else if (strcmp(componente.simbolo, "Si") == 0) printf("Silicio ");
    else if (strcmp(componente.simbolo, "P") == 0) printf("Fósforo ");
    else if (strcmp(componente.simbolo, "S") == 0) printf("Azufre ");
    else if (strcmp(componente.simbolo, "Cl") == 0) printf("Cloro ");
    else if (strcmp(componente.simbolo, "Ar") == 0) printf("Argón ");
    else if (strcmp(componente.simbolo, "K") == 0) printf("Potasio ");
    else if (strcmp(componente.simbolo, "Ca") == 0) printf("Calcio ");
    else if (strcmp(componente.simbolo, "Sc") == 0) printf("Escandio ");
    else if (strcmp(componente.simbolo, "Ti") == 0) printf("Titanio ");
    else if (strcmp(componente.simbolo, "V") == 0) printf("Vanadio ");
    else if (strcmp(componente.simbolo, "Cr") == 0) printf("Cromo ");
    else if (strcmp(componente.simbolo, "Mn") == 0) printf("Manganeso ");
    else if (strcmp(componente.simbolo, "Fe") == 0) printf("Hierro ");
    else if (strcmp(componente.simbolo, "Co") == 0) printf("Cobalto ");
    else if (strcmp(componente.simbolo, "Ni") == 0) printf("Níquel ");
    else if (strcmp(componente.simbolo, "Cu") == 0) printf("Cobre ");
    else if (strcmp(componente.simbolo, "Zn") == 0) printf("Zinc ");
    else if (strcmp(componente.simbolo, "Ga") == 0) printf("Galio ");
    else if (strcmp(componente.simbolo, "Ge") == 0) printf("Germanio ");
    else if (strcmp(componente.simbolo, "As") == 0) printf("Arsénico ");
    else if (strcmp(componente.simbolo, "Se") == 0) printf("Selenio ");
    else if (strcmp(componente.simbolo, "Br") == 0) printf("Bromo ");
    else if (strcmp(componente.simbolo, "Kr") == 0) printf("Kriptón ");
    else if (strcmp(componente.simbolo, "Rb") == 0) printf("Rubidio ");
    else if (strcmp(componente.simbolo, "Sr") == 0) printf("Estroncio ");
    else if (strcmp(componente.simbolo, "Y") == 0) printf("Itrio ");
    else if (strcmp(componente.simbolo, "Zr") == 0) printf("Circonio ");
    else if (strcmp(componente.simbolo, "Mo") == 0) printf("Molibdeno ");
    else if (strcmp(componente.simbolo, "Pd") == 0) printf("Paladio ");
    else if (strcmp(componente.simbolo, "Ag") == 0) printf("Plata ");
    else if (strcmp(componente.simbolo, "Cd") == 0) printf("Cadmio ");
    else if (strcmp(componente.simbolo, "Sn") == 0) printf("Estaño ");
    else if (strcmp(componente.simbolo, "I") == 0) printf("Yodo ");
    else if (strcmp(componente.simbolo, "Xe") == 0) printf("Xenón ");
    else if (strcmp(componente.simbolo, "Cs") == 0) printf("Cesio ");
    else if (strcmp(componente.simbolo, "Ba") == 0) printf("Bario ");
    else if (strcmp(componente.simbolo, "Pt") == 0) printf("Platino ");
    else printf("%s ", componente.simbolo);

    if (componente.cantidad > 1) {
        printf("(x%d) ", componente.cantidad);
    }
    printf("\n");
}

int main() {
    printf("Introduce una fórmula química:\n");
    yyparse();
    return 0;
}
