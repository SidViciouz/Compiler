/****************************************************/
/* File: tiny.y                                     */
/* The TINY Yacc/Bison specification file           */
/* Compiler Construction: Principles and Practice   */
/* Kenneth C. Louden                                */
/****************************************************/
%{
#define YYPARSER /* distinguishes Yacc output from other code files */

#include "globals.h"
#include "util.h"
#include "scan.h"
#include "parse.h"
#include <stdio.h>

#define YYSTYPE TreeNode *
static char * savedName; /* for use in assignments */
static char * savedNamet;
static int savedLineNo;  /* ditto */
static int savedValue;
static TreeNode * savedTree; /* stores syntax tree for later return */

int yyerror(char * message);
static int yylex(void);

%}

%token RETURN WHILE INT VOID LBRACKET RBRACKET COMMA NEQ LTE GT GTE LBRACE RBRACE LCOMMENT RCOMMENT
%token IF ELSE REPEAT UNTIL
%token ID NUM 
%token ASSIGN EQ LT PLUS MINUS TIMES OVER LPAREN RPAREN SEMI
%token ERROR 

%% /* Grammar for TINY */

program     : declaration_list { savedTree = $1;}
	    ;
declaration_list : declaration_list declaration { YYSTYPE t = $1;
						if(t != NULL)
						{ while(t->sibling != NULL)
							t = t->sibling;
							t->sibling = $2;
							$$ = $1;}
							else $$ = $2;
						}
	    | declaration { $$ = $1;}
	    ;
declaration : var_declaration { $$ = $1;}
	    | fun_declaration { $$ = $1;}
	    ;
var_declaration : type_specifier id SEMI { $$ = newStmtNode(DeclareK);
					$$->attr.name = $2->attr.name;
					$$->child[0] = $1;
					}
	    | type_specifier id LBRACKET NUM { savedValue = atoi(tokenString);}
		RBRACKET SEMI  { $$ = newStmtNode(DeclareK);
				$$->attr.name = $2->attr.name;
				$$->child[0] = $1;
				$$->child[1] = newExpNode(ConstK);
				$$->child[1]->attr.val = savedValue;
				}
	    ;
type_specifier : INT { $$ = newExpNode(TypeK);
			$$->type = Integer;
			}
	    | VOID { $$ = newExpNode(TypeK);
			$$->type = Void;
			}
	    ;
fun_declaration : type_specifier id
		LPAREN params RPAREN compound_stmt {
						$$ = newStmtNode(DeclareK);
						$$->attr.name = $2->attr.name;
						$$->child[0] = $1;
						$$->child[1] = $4;
						$$->child[2] = $6;
						}
	    ;
id	    : ID { $$ = newExpNode(IdK);
		   $$->attr.name = copyString(tokenString);
		}
	    ;
params	    : param_list { $$ = $1;}
	    | VOID { $$ = newExpNode(TypeK);
			$$->type = Void;
			}
	    ;
param_list  : param_list COMMA param { YYSTYPE t = $1;
					if(t!=NULL)
					{ while(t->sibling != NULL)
						t = t->sibling;
						t->sibling = $3;
						$$ = $1;}
					else $$ = $3;
					}
						
	    | param { $$ = $1;}
	    ;
param	    : type_specifier id { 
				$$ = newStmtNode(DeclareK);
				$$->attr.name = $2->attr.name;
				$$->child[0] = $1;
				}
	    | type_specifier id
		LBRACKET RBRACKET { $$ = newStmtNode(DeclareK);
					$$->attr.name = $2->attr.name;
					$$->child[0] = $1;
					}
	    ;
compound_stmt : LBRACE local_declarations statement_list RBRACE { $$ = newStmtNode(CompoundK);
								$$->child[0] = $2;
								$$->child[1] = $3;
								}
	    ;
local_declarations : local_declarations var_declaration { YYSTYPE t = $1;
							if(t != NULL)
							{ while(t->sibling != NULL)
								t = t->sibling;
								t->sibling = $2;
								$$ = $1;
							}
							else $$ = $2;
							}
	    | %empty { $$ = NULL;}
	    ;
statement_list : statement_list statement { YYSTYPE t = $1;
						if( t != NULL)
						{ while(t->sibling != NULL)
							t = t->sibling;
							t->sibling = $2;
							$$ = $1;
						}
						else $$ = $2;
						}
	    | %empty { $$ = NULL;}
	    ;
statement   : expression_stmt { $$ = $1; }
	    | compound_stmt { $$ = $1; }
	    | selection_stmt { $$ = $1; }
	    | iteration_stmt { $$ = $1; }
	    | return_stmt { $$ = $1; }
	    ;
expression_stmt : expression SEMI { $$ = $1; }
	    | SEMI { $$ = NULL; }
	    ;
selection_stmt : IF LPAREN expression RPAREN statement { $$ = newStmtNode(IfK);
							$$->child[0] = $3;
							$$->child[1] = $5;
							} 
	    | IF LPAREN expression RPAREN statement ELSE statement { $$ = newStmtNode(IfK);
								$$->child[0] = $3;
								$$->child[1] = $5;
								$$->child[2] = $7;
								}
	    ;
iteration_stmt : WHILE LPAREN expression RPAREN statement { $$ = newStmtNode(WhileK);
							$$->child[0] = $3;
							$$->child[1] = $5;
							}
	    ;
return_stmt : RETURN SEMI { $$ = newStmtNode(ReturnK); } 
	    | RETURN expression SEMI { $$ = newStmtNode(ReturnK);
					$$->child[0] = $2;
					}
	    ;
expression  : var ASSIGN expression { $$ = newStmtNode(AssignK);
					$$->attr.name = $1->attr.name;
					$$->child[0] = $1;
					$$->child[1] = $3;
					}
	    | simple_expression { $$ = $1;}
	    ;
var	    : id { $$ = $1;}
	    | id LBRACKET expression RBRACKET { $$ = newExpNode(IdK);
						$$->attr.name = $1->attr.name;
						$$->child[0] = $3;
						}
						
	    ;
simple_expression : additive_expression relop additive_expression { $$ = newExpNode(OpK);
								$$->child[0] = $1;
								$$->child[1] = $3;
								$$->attr.op = $2->attr.op;
								}
	    | additive_expression { $$ = $1;}
	    ;
relop	    : LTE { $$ = newExpNode(OpK);
			$$->attr.op = LTE;
			}
	    | LT { $$ = newExpNode(OpK);
			$$->attr.op = LT;
			}
	    | GT { $$ = newExpNode(OpK);
			$$->attr.op = GT;
			}
	    | GTE { $$ = newExpNode(OpK);
			$$->attr.op = GTE;
			}
	    | EQ { $$ = newExpNode(OpK);
			$$->attr.op = EQ;
			}
	    | NEQ { $$ = newExpNode(OpK);
			$$->attr.op = NEQ;
			}
	    ;
additive_expression : additive_expression addop term { $$ = newExpNode(OpK);
							$$->child[0] = $1;
							$$->child[1] = $3;
							$$->attr.op = $2->attr.op;
							}
	    | term { $$ = $1; }
	    ;
addop	    : PLUS { $$ = newExpNode(OpK);
			$$->attr.op = PLUS;
			}
	    | MINUS { $$ = newExpNode(OpK);
			$$->attr.op = MINUS;
			}
	    ;
term	    : term mulop factor { $$ = newExpNode(OpK);
				$$->child[0] = $1;
				$$->child[1] = $3;
				$$->attr.op = $2->attr.op;
				}
	    | factor {$$ = $1;}
	    ;
mulop	    : TIMES { $$ = newExpNode(OpK);
			$$->attr.op = TIMES;
			}
	    | OVER { $$ = newExpNode(OpK);
			$$->attr.op = OVER;
			}
	    ;
factor	    : LPAREN expression RPAREN { $$ = $2; }
	    | var { $$ = $1;}
	    | call { $$ = $1;}
	    | NUM { $$ = newExpNode(ConstK);
			$$->attr.val = atoi(tokenString);
			}
	    ;
call	    : id LPAREN args RPAREN { $$ = newStmtNode(CallK);
					$$->attr.name = $1->attr.name;
					$$->child[0] = $3;
					}
	    ;
args	    : arg_list { $$ = $1;}
	    | %empty {$$ = NULL;}
	    ;
arg_list    : arg_list COMMA expression { YYSTYPE t = $1;
					if(t!=NULL)
					{ while(t->sibling != NULL)
						t = t->sibling;
						t->sibling = $3;
						$$ = $1;}
					else $$ = $3;
					}
	    | expression { $$ = $1;}
	    ;

%%

int yyerror(char * message)
{ fprintf(listing,"Syntax error at line %d: %s\n",lineno,message);
  fprintf(listing,"Current token: ");
  printToken(yychar,tokenString);
  Error = TRUE;
  return 0;
}

/* yylex calls getToken to make Yacc/Bison output
 * compatible with ealier versions of the TINY scanner
 */
static int yylex(void)
{return getToken(); }

TreeNode * parse(void)
{ yyparse();
  return savedTree;
}

