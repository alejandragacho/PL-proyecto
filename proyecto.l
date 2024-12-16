%{
#include "proyecto.tab.h"  /* Incluir definiciones de tokens de Bison */
#include <stdio.h>
%}
%option yylineno

/* Definición de patrones */
ELEMENTO    (H|He|Li|Be|B|C|N|O|F|Ne|Na|Mg|Al|Si|P|S|Cl|Ar|K|Ca|Sc|Ti|V|Cr|Mn|Fe|Co|Ni|Cu|Zn|Ga|Ge|As|Se|Br|Kr|Rb|Sr|Y|Zr|Mo|Pd|Ag|Cd|Sn|I|Xe|Cs|Ba|Pt)
SUBINDICE   [0-9]+
SALTO       [\n]+
ESPACIO     [ \t]+

%%


{ELEMENTO}    { yylval.str = strdup(yytext); return ELEMENTO; }
{SUBINDICE}   { yylval.num = atoi(yytext);  return SUBINDICE; }
{SALTO}       { return SALTO; }
{ESPACIO}     { }
.             { fprintf(stderr, "Error léxico: %s en la línea %d\n", yytext, yylineno); }

%%

int yywrap() { return 1; }
