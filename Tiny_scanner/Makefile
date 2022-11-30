CC = gcc

OBJS = main.o util.o lex.yy.o

hw1_binary : $(OBJS)
	$(CC) -g -o hw1_binary $(OBJS) -ll

main.o : main.c util.h globals.h
	$(CC) -c main.c

util.o : util.c util.h globals.h
	$(CC) -c util.c

lex.yy.o : lex.yy.c
	$(CC) -c lex.yy.c

lex.yy.c : lex/tiny.l
	flex lex/tiny.l

clean :
	rm main.o
	rm util.o
	rm lex.yy.o
	rm lex.yy.c
	rm hw1_binary
