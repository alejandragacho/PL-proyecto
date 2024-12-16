%{
#include "proyecto.tab.h"
#include <stdio.h>
%}
%option yylineno

ELEMENTO    H|He|Li|Be|B|C|N|O|F|Ne|Na|Mg|Al|Si|P|S|Cl|Ar|K|Ca|Sc|Ti|V|Cr|Mn|Fe|Co|Ni|Cu|Zn|Ga|Ge|As|Se|Br|Kr|Rb|Sr|Y|Zr|Mo|Pd|Ag|Cd|Sn|I|Xe|Cs|Ba|Pt
SUBINDICE   [0-9]+
SALTO       [\n]+
ESPACIO     [ \t]+

%%

{ELEMENTO}    { yylval.str = strdup(yytext); printf("ELEMENTO: %s\n", yytext); return ELEMENTO; }

{SUBINDICE}   { yylval.num = atoi(yytext); printf("SUBINDICE: %s\n", yytext); return SUBINDICE; }

{SALTO}       { printf("SALTO: %s\n", yytext); return SALTO;}

{ESPACIO}     { /* Ignorar */ }

.           {        { fprintf(stderr, "Error léxico: %s en la línea %d\n", yytext, yylineno); } }
 

%%

int yywrap() { return 1; }