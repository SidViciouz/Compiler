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

newline     \n
whitespace  [ \t]+
digit       [0-9]
number      {digit}+
letter      [a-zA-Z]
identifier  {letter}+
lexicalerror {identifier}{number}|{number}{identifier}

%%

"return"	{return RETURN;}
"while"		{return WHILE;}
"int"		{return INT;}
"if"            {return IF;}
"void"		{return VOID;}
"else"          {return ELSE;}
"["		{return LBRACKET;}
"]"		{return RBRACKET;}
","		{return COMMA;}
"="            {return ASSIGN;}
"=="             {return EQ;}
"!="		{return NEQ;}
"<"             {return LT;}
"<="		{return LTE;}
">"		{return GT;}
">="		{return GTE;}
"+"             {return PLUS;}
"-"             {return MINUS;}
"*"             {return TIMES;}
"/"             {return OVER;}
"("             {return LPAREN;}
")"             {return RPAREN;}
";"             {return SEMI;}
{lexicalerror}  {return ERROR;}
{number}        {return NUM;}
{identifier}    {return ID;}
{newline}       {lineno++;}
{whitespace}    {/* skip whitespace */}
"{"		{return LBRACE;}
"}"		{return RBRACE;}
"/*"		{return LCOMMENT;}
"*/"		{return RCOMMENT;}


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
	  if(currentToken == LCOMMENT)
	  {
		TraceScan = FALSE;
	  }	  

	  else if(currentToken == RCOMMENT)
	  {
		//error occurs
	    	//fprintf(listing,"\t%d: ",lineno);
	    	//printToken(ERROR,"Comment Error");
	    	
		//printToTextFile(ERROR,"Comment Error");
		
	  }

	  if (TraceScan)
	  {
	    	//fprintf(listing,"\t%d: ",lineno);
	    	//printToken(currentToken,tokenString);
	    	
		//printToTextFile(currentToken,tokenString);
	  }

  }
  else
  {
	  if(currentToken == RCOMMENT)
	  {
		TraceScan = TRUE;
	  }
	  else if(currentToken == ENDFILE)
	  {
	    	//fprintf(listing,"\t%d: ",lineno);
	    	//printToken(ERROR,"Comment Error");
	    	
		//printToTextFile(ERROR,"Comment Error");

		//fprintf(listing,"\t%d: ",lineno);
		//printToken(currentToken,tokenString);
	   	//printToTextFile(currentToken,tokenString);
	  }
  }
  return currentToken;
}

