CC = gcc

CODE = lex.yy.c y.tab.c util.c main.c

hw1_binary : $(CODE)
	$(CC) -g -o hw1_binary $(CODE) -ll

y.tab.c : yacc/tiny.y
	bison -dy yacc/tiny.y

lex.yy.c : lex/tiny.l
	flex lex/tiny.l

clean :
	rm y.tab.c
	rm lex.yy.c
	rm hw1_binary
