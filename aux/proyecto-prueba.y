%{
#include "proyecto.tab.h"
#include <stdio.h>
#include <string.h>
%}
%%

%token <str> ELEMENTO
%token <num> SUBINDICE
%token PAR_OPEN
%token PAR_CLOSE
%token ESPACIO

S:

formula:
    elemento                               
    | formula elemento                      
    | formula PAR_OPEN formula PAR_CLOSE   
    | formula PAR_OPEN formula PAR_CLOSE SUBINDICE 
    ;
