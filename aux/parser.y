%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int yylex();


%}

%token <string> ELEMENTO 
%token <int> SUBINDICE

