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
    ELSE = 274,
    REPEAT = 275,
    UNTIL = 276,
    ID = 277,
    NUM = 278,
    ASSIGN = 279,
    EQ = 280,
    LT = 281,
    PLUS = 282,
    MINUS = 283,
    TIMES = 284,
    OVER = 285,
    LPAREN = 286,
    RPAREN = 287,
    SEMI = 288,
    ERROR = 289
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
#define ELSE 274
#define REPEAT 275
#define UNTIL 276
#define ID 277
#define NUM 278
#define ASSIGN 279
#define EQ 280
#define LT 281
#define PLUS 282
#define MINUS 283
#define TIMES 284
#define OVER 285
#define LPAREN 286
#define RPAREN 287
#define SEMI 288
#define ERROR 289

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
