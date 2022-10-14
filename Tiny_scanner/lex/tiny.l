/****************************************************/
/* File: tiny.l                                     */
/* Lex specification for TINY                       */
/* Compiler Construction: Principles and Practice   */
/* Kenneth C. Louden                                */
/****************************************************/

%{
#include "globals.h"
#include "util.h"
#include "scan.h"
/* lexeme of identifier or reserved word */
char tokenString[MAXTOKENLEN+1];
%}

digit       [0-9]
number      {digit}+
letter      [a-zA-Z]
identifier  {letter}+{number}*
newline     \n
whitespace  [ \t]+

%%

"["		{return LBRACKET;}
"]"		{return RBRACKET;}
","		{return COMMA;}
"return"	{return RETURN;}
"while"		{return WHILE;}
"/*"		{return COMMENTB;}
"*/"		{return COMMENTE;}
"int"		{return INT;}
"if"            {return IF;}
"then"          {return THEN;}
"else"          {return ELSE;}
"end"           {return END;}
"repeat"        {return REPEAT;}
"until"         {return UNTIL;}
"read"          {return READ;}
"write"         {return WRITE;}
":="            {return ASSIGN;}
"="             {return EQ;}
"<"             {return LT;}
"+"             {return PLUS;}
"-"             {return MINUS;}
"*"             {return TIMES;}
"/"             {return OVER;}
"("             {return LPAREN;}
")"             {return RPAREN;}
";"             {return SEMI;}
{number}        {return NUM;}
{identifier}    {return ID;}
{newline}       {lineno++;}
{whitespace}    {/* skip whitespace */}
"{"		{return LBRACE;}
"}"		{return RBRACE;}
"{"             { char c;
                  do
                  { c = input();
                    if (c == EOF) break;
                    if (c == '\n') lineno++;
                  } while (c != '}');
                }
.               {return ERROR;}

%%

TokenType getToken(void)
{ static int firstTime = TRUE;
  TokenType currentToken;
  if (firstTime)
  { firstTime = FALSE;
    lineno++;
    yyin = source;
    yyout = listing;
    TraceScan = TRUE;
  }
  currentToken = yylex();
  strncpy(tokenString,yytext,MAXTOKENLEN);
  
  if(TraceScan == TRUE)
  {
	  if(currentToken == COMMENTB)
	  {
		TraceScan = FALSE;
	  }	  

	  else if(currentToken == COMMENTE)
	  {
		//error occurs
	    	fprintf(listing,"\t%d: ",lineno);
	    	printToken(ERROR,"Comment Error");
	    	printToTextFile(ERROR,"Comment Error");
		
	  }

	  if (TraceScan)
	  {
	    	fprintf(listing,"\t%d: ",lineno);
	    	printToken(currentToken,tokenString);
	    	printToTextFile(currentToken,tokenString);
	  }

  }
  else
  {
	  if(currentToken == COMMENTE)
	  {
		TraceScan = TRUE;
	  }
	  else if(currentToken == ENDFILE)
	  {
	    	fprintf(listing,"\t%d: ",lineno);
	    	printToken(ERROR,"Comment Error");
	    	printToTextFile(ERROR,"Comment Error");

		fprintf(listing,"\t%d: ",lineno);
		printToken(currentToken,tokenString);
	   	printToTextFile(currentToken,tokenString);
	  }
  }
  

  return currentToken;
}

