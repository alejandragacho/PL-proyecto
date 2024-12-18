FUENTE = proyecto
PRUEBA = pruebas.txt
LIB = lfl

all: compile run

compile:
	flex $(FUENTE).l
	bison -o $(FUENTE).tab.c $(FUENTE).y -yd --verbose
	gcc -o $(FUENTE) lex.yy.c $(FUENTE).tab.c -$(LIB) -lfl

run:
	./$(FUENTE) < $(PRUEBA)

run2:
	./$(FUENTE) $(PRUEBA)

clean:
	rm $(FUENTE) lex.yy.c $(FUENTE).tab.c $(FUENTE).tab.h
