/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    RETURN = 258,
    WHILE = 259,
    INT = 260,
    VOID = 261,
    LBRACKET = 262,
    RBRACKET = 263,
    COMMA = 264,
    NEQ = 265,
    LTE = 266,
    GT = 267,
    GTE = 268,
    LBRACE = 269,
    RBRACE = 270,
    LCOMMENT = 271,
    RCOMMENT = 272,
    IF = 273,
    THEN = 274,
    ELSE = 275,
    END = 276,
    REPEAT = 277,
    UNTIL = 278,
    READ = 279,
    WRITE = 280,
    ID = 281,
    NUM = 282,
    ASSIGN = 283,
    EQ = 284,
    LT = 285,
    PLUS = 286,
    MINUS = 287,
    TIMES = 288,
    OVER = 289,
    LPAREN = 290,
    RPAREN = 291,
    SEMI = 292,
    ERROR = 293
  };
#endif
/* Tokens.  */
#define RETURN 258
#define WHILE 259
#define INT 260
#define VOID 261
#define LBRACKET 262
#define RBRACKET 263
#define COMMA 264
#define NEQ 265
#define LTE 266
#define GT 267
#define GTE 268
#define LBRACE 269
#define RBRACE 270
#define LCOMMENT 271
#define RCOMMENT 272
#define IF 273
#define THEN 274
#define ELSE 275
#define END 276
#define REPEAT 277
#define UNTIL 278
#define READ 279
#define WRITE 280
#define ID 281
#define NUM 282
#define ASSIGN 283
#define EQ 284
#define LT 285
#define PLUS 286
#define MINUS 287
#define TIMES 288
#define OVER 289
#define LPAREN 290
#define RPAREN 291
#define SEMI 292
#define ERROR 293

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
