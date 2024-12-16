%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

void yyerror(const char *s);
extern int yylex();
extern int yylineno;

/* Declaración de funciones auxiliares */
char* get_componente(char* compuesto);
char* describe(char* elemento, int numero);
char* concat(const char* str1, const char* str2, const char* str3);
char* prefijo(int numero);
char* nombre_trivial(const char* compuesto);
char* hidruro_metalico(const char* compuesto);
char* es_acido(const char* compuesto);
char* es_oxido(const char* compuesto);
char* generar_binario(const char* compuesto);

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
%token LPAREN RPAREN
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
        printf("Resultado: %s\n\n", $1);
        free($1); // Liberar memoria asignada dinámicamente
    }
;

compuesto:
    ELEMENTO{ printf( "%s\n", get_componente($1)); }
    |secuencia_elementos{
        printf("Compuesto recibido: %s\n", $1);

        // 1. Verificar si el compuesto tiene un nombre trivial
        char* nombre_comun = nombre_trivial($1);
        if (nombre_comun) {
            $$ = strdup(nombre_comun);
        } else {
            // 2. Verificar si es un ácido hidrácido
            char* acido = es_acido($1);
            if (acido) {
                $$ = strdup(acido);
                free(acido);
            } else {
                // 3. Verificar si es un óxido
                char* oxido = es_oxido($1);
                if (oxido) {
                    $$ = strdup(oxido);
                    free(oxido);
                } else {
                    // 4. Si no es ninguna de las anteriores, asumir "–uro de"
                    char* binario = generar_binario($1);
                    $$ = strdup(binario);
                    free(binario);
                }
            }
        }
        free($1);
    }
;


secuencia_elementos:
    ELEMENTO SUBINDICE secuencia_elementos {
        char compuesto[200];
        sprintf(compuesto, "%s%d%s", $1, $2, $3 ? $3 : ""); // Concatenar H2 + S + resto
        $$ = strdup(compuesto);
        free($1);
        if ($3) free($3);
    }
    | ELEMENTO SUBINDICE {
        char compuesto[50];
        sprintf(compuesto, "%s%d", $1, $2); // Ejemplo: H2
        $$ = strdup(compuesto);
        free($1);
    }
    | ELEMENTO secuencia_elementos {
        char compuesto[200];
        sprintf(compuesto, "%s%s", $1, $2 ? $2 : ""); // Concatenar H + S + resto
        $$ = strdup(compuesto);
        free($1);
        if ($2) free($2);
    }
    | ELEMENTO {
        $$ = strdup($1); // Ejemplo: H o S solos
        free($1);
    }
;

%%

char* get_componente(char* simbolo) {
    if (strcmp(simbolo, "H") == 0) return("Hidrógeno");
    else if (strcmp(simbolo, "He") == 0) return("Helio");
    else if (strcmp(simbolo, "Li") == 0) return("Litio");
    else if (strcmp(simbolo, "Be") == 0) return("Berilio");
    else if (strcmp(simbolo, "B") == 0) return("Boro");
    else if (strcmp(simbolo, "C") == 0) return("Carbono");
    else if (strcmp(simbolo, "N") == 0) return("Nitrógeno");
    else if (strcmp(simbolo, "O") == 0) return("Oxígeno");
    else if (strcmp(simbolo, "F") == 0) return("Flúor");
    else if (strcmp(simbolo, "Ne") == 0) return("Neón");
    else if (strcmp(simbolo, "Na") == 0) return("Sodio");
    else if (strcmp(simbolo, "Mg") == 0) return("Magnesio");
    else if (strcmp(simbolo, "Al") == 0) return("Aluminio");
    else if (strcmp(simbolo, "Si") == 0) return("Silicio");
    else if (strcmp(simbolo, "P") == 0) return("Fósforo");
    else if (strcmp(simbolo, "S") == 0) return("Azufre");
    else if (strcmp(simbolo, "Cl") == 0) return("Cloro");
    else if (strcmp(simbolo, "Ar") == 0) return("Argón");
    else if (strcmp(simbolo, "K") == 0) return("Potasio");
    else if (strcmp(simbolo, "Ca") == 0) return("Calcio");
    else if (strcmp(simbolo, "Sc") == 0) return("Escandio");
    else if (strcmp(simbolo, "Ti") == 0) return("Titanio");
    else if (strcmp(simbolo, "V") == 0) return("Vanadio");
    else if (strcmp(simbolo, "Cr") == 0) return("Cromo");
    else if (strcmp(simbolo, "Mn") == 0) return("Manganeso");
    else if (strcmp(simbolo, "Fe") == 0) return("Hierro");
    else if (strcmp(simbolo, "Co") == 0) return("Cobalto");
    else if (strcmp(simbolo, "Ni") == 0) return("Níquel");
    else if (strcmp(simbolo, "Cu") == 0) return("Cobre");
    else if (strcmp(simbolo, "Zn") == 0) return("Zinc");
    else if (strcmp(simbolo, "Ga") == 0) return("Galio");
    else if (strcmp(simbolo, "Ge") == 0) return("Germanio");
    else if (strcmp(simbolo, "As") == 0) return("Arsénico");
    else if (strcmp(simbolo, "Se") == 0) return("Selenio");
    else if (strcmp(simbolo, "Br") == 0) return("Bromo");
    else if (strcmp(simbolo, "Kr") == 0) return("Kriptón");
    else if (strcmp(simbolo, "Rb") == 0) return("Rubidio");
    else if (strcmp(simbolo, "Sr") == 0) return("Estroncio");
    else if (strcmp(simbolo, "Y") == 0) return("Itrio");
    else if (strcmp(simbolo, "Zr") == 0) return("Circonio");
    else if (strcmp(simbolo, "Mo") == 0) return("Molibdeno");
    else if (strcmp(simbolo, "Pd") == 0) return("Paladio");
    else if (strcmp(simbolo, "Ag") == 0) return("Plata");
    else if (strcmp(simbolo, "Cd") == 0) return("Cadmio");
    else if (strcmp(simbolo, "Sn") == 0) return("Estaño");
    else if (strcmp(simbolo, "I") == 0) return("Yodo");
    else if (strcmp(simbolo, "Xe") == 0) return("Xenón");
    else if (strcmp(simbolo, "Cs") == 0) return("Cesio");
    else if (strcmp(simbolo, "Ba") == 0) return("Bario");
    else if (strcmp(simbolo, "Pt") == 0) return("Platino");
    else return("%s ", simbolo);

}

char* nombre_trivial(const char* compuesto) {
    printf("Fórmula:  %s\n", compuesto);
    if (strcmp(compuesto, "H2O") == 0) return "Agua";
    if (strcmp(compuesto, "CO2") == 0) return "Dióxido de carbono";
    if (strcmp(compuesto, "NH3") == 0) return "Amoníaco";
    if (strcmp(compuesto, "CH4") == 0) return "Metano";
    if (strcmp(compuesto, "C2H6") == 0) return "Etano";
    if (strcmp(compuesto, "C3H8") == 0) return "Propano";
    if (strcmp(compuesto, "C4H10") == 0) return "Butano";
    if (strcmp(compuesto, "PH3") == 0) return "Fosfina";
    if (strcmp(compuesto, "SiH4") == 0) return "Silano";
    if (strcmp(compuesto, "CO") == 0) return "Monóxido de carbono";
    if (strcmp(compuesto, "NaCl") == 0) return "Cloruro de sodio (sal de mesa)";
    if (strcmp(compuesto, "HCl") == 0) return "Ácido clorhídrico";
    if (strcmp(compuesto, "H2SO4") == 0) return "Ácido sulfúrico";
    if (strcmp(compuesto, "HNO3") == 0) return "Ácido nítrico";
    if (strcmp(compuesto, "H3PO4") == 0) return "Ácido fosfórico";
    if (strcmp(compuesto, "H2CO2") == 0) return "Ácido carbónico";
    if (strcmp(compuesto, "HF") == 0) return "Ácido fluorhídrico";
    if (strcmp(compuesto, "HBr") == 0) return "Ácido bromhídrico";
    if (strcmp(compuesto, "HI") == 0) return "Ácido yodhídrico";
    if (strcmp(compuesto, "HCN") == 0) return "Ácido cianhídrico";
    if (strcmp(compuesto, "H2S") == 0) return "Ácido sulfhídrico";
    if (strcmp(compuesto, "H2O2") == 0) return "Peróxido de hidrógeno";
    if (strcmp(compuesto, "O3") == 0) return "Ozono";
    if (strcmp(compuesto, "NaHCO3") == 0) return "Bicarbonato de sodio";
    if (strcmp(compuesto, "NaOH") == 0) return "Hidróxido de sodio";
    if (strcmp(compuesto, "KOH") == 0) return "Hidróxido de potasio";
    if (strcmp(compuesto, "N2O") == 0) return "Óxido nitroso";
    if (strcmp(compuesto, "C6H12O6") == 0) return "Glucosa";
    if (strcmp(compuesto, "C2H6O") == 0) return "Etanol";
    if (strcmp(compuesto, "C6H6") == 0) return "Benceno";
    return NULL; // Si no hay un nombre común, devuelve NULL
}

char* hidruro_metalico(const char* compuesto) {
    printf("Fórmula: %s\n", compuesto); 
    int len = strlen(compuesto);
    if (len < 2) return NULL;

    // Verificar si la cadena termina en "H" o "H" seguido de un número (subíndice)
    if (compuesto[len - 1] == 'H' || (isdigit(compuesto[len - 1]) && compuesto[len - 2] == 'H')) {
        char simbolo_metal[10] = {0};
        int i = len - 1;

        // Retroceder para ignorar el "H" y cualquier subíndice (números)
        while (i >= 0 && (isdigit(compuesto[i]) || compuesto[i] == 'H')) {
            i--;
        }

        // Retroceder hasta el inicio del símbolo metálico (última letra mayúscula + opcionalmente una minúscula)
        int start = i;
        if (start > 0 && islower(compuesto[start])) {
            start--; // Incluye la letra minúscula si existe
        }
        while (start > 0 && isupper(compuesto[start - 1])) {
            start--; // Retrocede a la última mayúscula
        }

        // Copiar el símbolo del metal
        strncpy(simbolo_metal, &compuesto[start], i - start + 1);
        simbolo_metal[i - start + 1] = '\0';

    

        // Buscar el nombre del metal
        char* metal = get_componente(simbolo_metal);
        if (metal) {
            char* resultado = (char*)malloc(100);
            sprintf(resultado, "Hidruro de %s", metal);
            return resultado;
        } else {
            printf("Error: No se encontró el nombre para el símbolo '%s'\n", simbolo_metal);
        }
    }
    return NULL;
}

char* es_acido(const char* compuesto) {
    if (compuesto[0] == 'H') { // Si comienza con H (hidrógeno)
        int i = 1; // Posición inicial después de H

        // Ignorar subíndices después de la H (por ejemplo, "2" en H2S)
        while (isdigit(compuesto[i])) i++;

        char simbolo_no_metal[10] = {0};

        // Extraer el símbolo del no metal (1 o 2 letras después de los números)
        if (islower(compuesto[i + 1])) {
            strncpy(simbolo_no_metal, &compuesto[i], 2); // Símbolo de 2 letras
            simbolo_no_metal[2] = '\0';
        } else {
            strncpy(simbolo_no_metal, &compuesto[i], 1); // Símbolo de 1 letra
            simbolo_no_metal[1] = '\0';
        }

        // Construir el nombre del ácido
        char* resultado = (char*)malloc(100);
        sprintf(resultado, "Ácido %shídrico",
            (strcmp(simbolo_no_metal, "F") == 0) ? "fluor" :
            (strcmp(simbolo_no_metal, "Cl") == 0) ? "clor" :
            (strcmp(simbolo_no_metal, "Br") == 0) ? "brom" :
            (strcmp(simbolo_no_metal, "I") == 0) ? "yod" :
            (strcmp(simbolo_no_metal, "S") == 0) ? "sulf" :
            (strcmp(simbolo_no_metal, "Se") == 0) ? "selen" :
            (strcmp(simbolo_no_metal, "Te") == 0) ? "telur" :
            "desconocido");

        // Si no coincide con un no metal conocido, liberar y retornar NULL
        if (strcmp(resultado, "Ácido desconocidohídrico") == 0) {
            free(resultado);
            return NULL;
        }

        return resultado;
    }
    return NULL; // No comienza con H, no es un ácido
}

char* es_oxido(const char* compuesto) {
    printf("Verificando si es un óxido: %s\n", compuesto); // Depuración

    int len = strlen(compuesto);
    char simbolo_elemento[10] = {0};
    int subindice_oxigeno = 1; // Subíndice por defecto para "O"

    // Buscar el símbolo del elemento principal (antes de "O")
    int i = 0, j = 0;
    while (i < len && compuesto[i] != 'O') {
        if (isupper(compuesto[i])) {
            if (j > 0) break; // Si ya hay otro símbolo, detener
            simbolo_elemento[j++] = compuesto[i];
        } else if (islower(compuesto[i])) {
            simbolo_elemento[j++] = compuesto[i];
        }
        i++;
    }
    simbolo_elemento[j] = '\0'; // Terminar la cadena del símbolo del elemento

    // Verificar si contiene "O" y leer su subíndice
    if (i < len && compuesto[i] == 'O') {
        i++;
        if (isdigit(compuesto[i])) {
            subindice_oxigeno = compuesto[i] - '0'; // Extraer el subíndice del oxígeno
        }
    } else {
        return NULL; // No es un óxido válido
    }

    // Obtener el nombre del elemento principal
    char* nombre_elemento = get_componente(simbolo_elemento);
    if (!nombre_elemento) {
        printf("No se reconoce el elemento: %s\n", simbolo_elemento);
        return NULL;
    }

    // Construir el nombre del óxido con el prefijo
    char* resultado = (char*)malloc(100);
    if (subindice_oxigeno == 1) {
        sprintf(resultado, "Óxido de %s", nombre_elemento);
    } else {
        sprintf(resultado, "%sóxido de %s", prefijo(subindice_oxigeno), nombre_elemento);
    }
    return resultado;
}

char* generar_binario(const char* compuesto) {
    char simbolo_izquierda[10] = {0}, simbolo_derecha[10] = {0};
    int i = 0, j = 0;

    // Extraer el primer símbolo (izquierda del compuesto)
    while (compuesto[i] && isalpha(compuesto[i])) {
        simbolo_izquierda[j++] = compuesto[i++];
        if (isupper(compuesto[i])) break; // Nueva mayúscula indica segundo símbolo
    }
    simbolo_izquierda[j] = '\0';

    // Saltar números si existen
    while (isdigit(compuesto[i])) i++;

    // Extraer el segundo símbolo (derecha del compuesto)
    j = 0;
    while (compuesto[i] && isalpha(compuesto[i])) {
        simbolo_derecha[j++] = compuesto[i++];
    }
    simbolo_derecha[j] = '\0';

    // Validar símbolos extraídos
    if (strlen(simbolo_derecha) == 0 || strlen(simbolo_izquierda) == 0) {
        return strdup(compuesto); // Devuelve el compuesto original si no hay símbolos válidos
    }

    // Obtener los nombres completos usando get_componente
    const char* nombre_izquierda = get_componente(simbolo_izquierda);
    const char* nombre_derecha = get_componente(simbolo_derecha);

    // Si no encuentra el nombre de algún componente, devuelve el compuesto original
    if (!nombre_izquierda || !nombre_derecha) {
        return strdup(compuesto);
    }

    // Añadir el sufijo "–uro" al nombre del símbolo derecho
    char nombre_derecha_uro[50];
    sprintf(nombre_derecha_uro, "%suro", nombre_derecha);

    // Construir el nombre final
    char* resultado = (char*)malloc(100);
    sprintf(resultado, "%s de %s", nombre_derecha_uro, nombre_izquierda);

    return resultado;
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
    
    int formulas_procesadas = 0;
    while (!feof(stdin)) { // Leer entrada hasta el final del archivo
        yyparse();
        formulas_procesadas++;
    }
    printf("%d fórmulas procesadas.\n", formulas_procesadas);
    printf("Fin del análisis.\n");
    return 0;


}