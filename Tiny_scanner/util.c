/****************************************************/
/* File: util.c                                     */
/* Utility function implementation                  */
/* for the TINY compiler                            */
/* Compiler Construction: Principles and Practice   */
/* Kenneth C. Louden                                */
/****************************************************/

#include "globals.h"
#include "util.h"

/* Procedure printToken prints a token 
 * and its lexeme to the listing file
 */
void printToken( TokenType token, const char* tokenString )
{ switch (token)
  {
    case VOID : fprintf(listing,"VOID\t%s\n",tokenString); break;
    case NEQ : fprintf(listing,"!=\t%s\n",tokenString); break;
    case LTE : fprintf(listing,"<=\t%s\n",tokenString); break;
    case GT : fprintf(listing,">\t%s\n",tokenString); break;
    case GTE : fprintf(listing,">=\t%s\n",tokenString); break; 
    case LCOMMENT : break;
    case RCOMMENT : break; 
    case LBRACKET: fprintf(listing,"[\t%s\n",tokenString); break;
    case RBRACKET: fprintf(listing,"]\t%s\n",tokenString); break;
    case COMMA: fprintf(listing,",\t%s\n",tokenString); break;
    case RETURN: fprintf(listing,"RETURN\t%s\n",tokenString); break;
    case WHILE: fprintf(listing,"WHILE\t%s\n",tokenString); break;
    case LBRACE: fprintf(listing,"{\t%s\n",tokenString); break;
    case RBRACE: fprintf(listing,"}\t%s\n",tokenString); break;
    case INT: fprintf(listing,"INT\t%s\n",tokenString); break;
    case IF: fprintf(listing,"IF\t%s\n",tokenString); break;
    case ELSE: fprintf(listing,"ELSE\t%s\n",tokenString); break;
    case ASSIGN: fprintf(listing,"=\n"); break;
    case LT: fprintf(listing,"<\n"); break;
    case EQ: fprintf(listing,"==\n"); break;
    case LPAREN: fprintf(listing,"(\n"); break;
    case RPAREN: fprintf(listing,")\n"); break;
    case SEMI: fprintf(listing,";\n"); break;
    case PLUS: fprintf(listing,"+\n"); break;
    case MINUS: fprintf(listing,"-\n"); break;
    case TIMES: fprintf(listing,"*\n"); break;
    case OVER: fprintf(listing,"/\n"); break;
    case ENDFILE: fprintf(listing,"EOF\n"); break;
    case NUM:
      fprintf(listing,
          "NUM, val= %s\n",tokenString);
      break;
    case ID:
      fprintf(listing,
          "ID, name= %s\n",tokenString);
      break;
    case ERROR:
      fprintf(listing,
          "ERROR: %s\n",tokenString);
      break;
    default: /* should never happen */
      fprintf(listing,"Unknown token: %d\n",token);
  }
}

/* Function newStmtNode creates a new statement
 * node for syntax tree construction
 */
TreeNode * newStmtNode(StmtKind kind)
{ TreeNode * t = (TreeNode *) malloc(sizeof(TreeNode));
  int i;
  if (t==NULL)
    fprintf(listing,"Out of memory error at line %d\n",lineno);
  else {
    for (i=0;i<MAXCHILDREN;i++) t->child[i] = NULL;
    t->sibling = NULL;
    t->nodekind = StmtK;
    t->kind.stmt = kind;
    t->lineno = lineno;
  }
  return t;
}

/* Function newExpNode creates a new expression 
 * node for syntax tree construction
 */
TreeNode * newExpNode(ExpKind kind)
{ TreeNode * t = (TreeNode *) malloc(sizeof(TreeNode));
  int i;
  if (t==NULL)
    fprintf(listing,"Out of memory error at line %d\n",lineno);
  else {
    for (i=0;i<MAXCHILDREN;i++) t->child[i] = NULL;
    t->sibling = NULL;
    t->nodekind = ExpK;
    t->kind.exp = kind;
    t->lineno = lineno;
    t->type = Void;
  }
  return t;
}

/* Function copyString allocates and makes a new
 * copy of an existing string
 */
char * copyString(char * s)
{ int n;
  char * t;
  if (s==NULL) return NULL;
  n = strlen(s)+1;
  t = malloc(n);
  if (t==NULL)
    fprintf(listing,"Out of memory error at line %d\n",lineno);
  else strcpy(t,s);
  return t;
}

/* Variable indentno is used by printTree to
 * store current number of spaces to indent
 */
static indentno = 0;

/* macros to increase/decrease indentation */
#define INDENT indentno+=2
#define UNINDENT indentno-=2

/* printSpaces indents by printing spaces */
static void printSpaces(void)
{ int i;
  for (i=0;i<indentno;i++)
    fprintf(listing," ");
}

/* procedure printTree prints a syntax tree to the 
 * listing file using indentation to indicate subtrees
 */
void printTree( TreeNode * tree )
{ int i;
  INDENT;
  while (tree != NULL) {
    printSpaces();
    if (tree->nodekind==StmtK)
    { switch (tree->kind.stmt) {
        case IfK:
          fprintf(listing,"If\n");
          break;
        case RepeatK:
          fprintf(listing,"Repeat\n");
          break;
        case AssignK:
          fprintf(listing,"Assign\n");
          break;
        case ReadK:
          fprintf(listing,"Read: %s\n",tree->attr.name);
          break;
        case WriteK:
          fprintf(listing,"Write\n");
          break;
	case VdeclareK:
	  fprintf(listing,"Variable Declare : %s\n",tree->attr.name);
	  break;
	case FdeclareK:
	  fprintf(listing,"Function Declare : %s\n",tree->attr.name);
	  break;
	case ParameterK:
	  fprintf(listing,"Parameter : %s\n",tree->attr.name);
	  break;
	case CompoundK:
	  fprintf(listing,"Compound Statement\n");
	  break;
	case WhileK:
	  fprintf(listing,"While\n");
	  break;
	case ReturnK:
	  fprintf(listing,"Return\n");
	  break;
	case CallK:
	  fprintf(listing,"Call\n");
	  break;
        default:
          fprintf(listing,"Unknown ExpNode kind\n");
          break;
      }
    }
    else if (tree->nodekind==ExpK)
    { switch (tree->kind.exp) {
	case SimK:
          fprintf(listing,"Simple Expression\n");
	  break;
	case AddK:
          fprintf(listing,"Additive Expression\n");
	  break;
	case VarK:
          fprintf(listing,"Varible : %s\n",tree->attr.name);
	  break;
        case OpK:
          fprintf(listing,"Operator: ");
          printToken(tree->attr.op,"\0");
          break;
        case ConstK:
          fprintf(listing,"Constant: %d\n",tree->attr.val);
          break;
        case IdK:
          fprintf(listing,"Id: %s\n",tree->attr.name);
          break;
	case TypeK:
	  if(tree->type == Integer)
	  	fprintf(listing,"Type: int\n");
	  else
	  	fprintf(listing,"Type: void\n");
	  break;
        default:
          fprintf(listing,"Unknown ExpNode kind\n");
          break;
      }
    }
    else fprintf(listing,"Unknown node kind\n");
    for (i=0;i<MAXCHILDREN;i++)
         printTree(tree->child[i]);
    tree = tree->sibling;
  }
  UNINDENT;
}

