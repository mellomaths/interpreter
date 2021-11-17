bison:
	bison -d code.y >> result.txt 2>&1

lex:
	lex code.l >> result.txt 2>&1

compile:
	cc lex.yy.c code.tab.c -o code -lfl >> result.txt 2>&1

create_interpreter:
	make yacc
	make lex
	make compile

run_sample:
	./code < exemplo

clean:
	rm -f code.tab.c code.tab.h lex.yy.c code
