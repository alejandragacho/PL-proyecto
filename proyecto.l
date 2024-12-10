%{
#include "proyecto.tab.h"
#include <stdio.h>
%}
%option yylineno

ELEMENTO    H|He|Li|Be|B|C|N|O|F|Ne|Na|Mg|Al|Si|P|S|Cl|Ar|K|Ca|Sc|Ti|V|Cr|Mn|Fe|Co|Ni|Cu|Zn|Ga|Ge|As|Se|Br|Kr|Rb|Sr|Y|Zr|Mo|Pd|Ag|Cd|Sn|I|Xe|Cs|Ba|Pt
SUBINDICE   [0-9]+
ESPACIO     [ \t\n]+

%%

ELEMENTO    { yylval.str = strdup(yytext); return ELEMENTO; }

SUBINDICE   { yylval.num = atoi(yytext); return SUBINDICE; }

ESPACIO     { /* Ignorar */ }

.           { printf("Elemento no reconocido: %s \n", yytext); }

%%

int yywrap() { return 1; }