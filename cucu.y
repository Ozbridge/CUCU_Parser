%{
    #include <stdlib.h>
    #include <stdio.h>
    int yylex();
    int yyerror(char *msg);
    extern FILE* out;
    FILE *ans;
%}

%token IF ELSE WHILE RETURN COMMENT MULTI_COMMENT
%union{
    char *str;
    int num;
}
%token <str> TYPE_STRING TYPE_INT STRING ID ADD SUB MUL DIV AND OR XOR L_PAREN R_PAREN L_CURL R_CURL L_SQ R_SQ SEMI COMMA LTQ GTQ LT GT EQ NEQ ASSIGN
%token <num> NUM
%left ADD SUB
%left MUL DIV
%left LT LTQ GT GTQ EQ NEQ
%left AND OR XOR
%left L_PAREN R_PAREN

%%

prg: var_dec prg
| func_dec prg
| func_def prg
|;

token: ID L_SQ expr R_SQ {fprintf(ans, "Pointer variable ID: %s\n", $1);}

val_list: ID COMMA val_list {fprintf(ans, "Variable ID: %s\n", $1);}
| NUM COMMA val_list {fprintf(ans, "Val: %d\n", $1);}
| token COMMA val_list
| STRING COMMA val_list {fprintf(ans, "Val: %s\n", $1);}
| ID {fprintf(ans, "Variable ID: %s\n", $1);}
| NUM {fprintf(ans, "Val: %d\n", $1);}
| STRING {fprintf(ans, "Val: %s\n", $1);}
| token
| ;

var_dec: type ID SEMI {
    fprintf(ans, "Variable ID: %s\n", $2);
    fprintf(ans, "Variable declaration\n");
}
| type token SEMI {
    fprintf(ans, "Variable declaration\n");
}
| type token ASSIGN expr SEMI {
    fprintf(ans, "Variable initialization\n");
}
| type ID ASSIGN expr SEMI {
    fprintf(ans, "Variable ID: %s\n", $2);
    fprintf(ans, "Variable Initialization\n");
}


func_dec: type ID L_PAREN func_args R_PAREN SEMI {fprintf(ans, "ID: %s\n", $2);}
func_def: type ID L_PAREN func_args R_PAREN func_body {fprintf(ans, "Function ID: %s\n", $2);}
func_args: func_args COMMA type ID {fprintf(ans, "Argument ID: %s\n", $4);}
| type ID {fprintf(ans, "Argument ID: %s\n", $2);}
|;

type: TYPE_INT {fprintf(ans, "Type: %s\n", $1);}
| TYPE_STRING {fprintf(ans, "Type: %s\n", $1);}

func_body: L_CURL stmtlist R_CURL {fprintf(ans, "Function body ends\n");}

stmtlist: stmt stmtlist
| stmt

stmtblock : stmt {fprintf(ans, "Statement Block Ends\n");}
| L_CURL stmtlist R_CURL {fprintf(ans, "Statement Block Ends\n");}

func_call: ID L_PAREN val_list R_PAREN {fprintf(ans, "Called Func ID: %s\n", $1);}

stmt: var_dec
| ID ASSIGN expr SEMI {fprintf(ans, "Variable ID: %s\nAssignment statement\n", $1);}
| token ASSIGN expr SEMI {fprintf(ans, "Assignment statement\n");}
| IF L_PAREN expr R_PAREN stmtblock {fprintf(ans, "IF statement\n");}
| IF L_PAREN expr R_PAREN stmtblock ELSE stmtblock {fprintf(ans, "IF ELSE statement\n");}
| RETURN expr SEMI {fprintf(ans, "Return with value\n");}
| RETURN SEMI {fprintf(ans, "Return without value\n");}
| WHILE L_PAREN expr R_PAREN stmtblock {fprintf(ans, "While loop\n");}
| func_call SEMI
| SEMI

expr : fact {fprintf(ans, "Expression ends\n");}

fact: fact LT fact {fprintf(ans, "%s\n", $2);}
| fact GT fact {fprintf(ans, "%s\n", $2);}
| fact LTQ fact {fprintf(ans, "%s\n", $2);}
| fact GTQ fact {fprintf(ans, "%s\n", $2);}
| fact EQ fact {fprintf(ans, "%s\n", $2);}
| fact AND fact {fprintf(ans, "%s\n", $2);}
| fact OR fact {fprintf(ans, "%s\n", $2);}
| fact XOR fact {fprintf(ans, "%s\n", $2);}
| fact NEQ fact {fprintf(ans, "%s\n", $2);}
| fact ADD fact {fprintf(ans, "%s\n", $2);}
| fact SUB fact {fprintf(ans, "%s\n", $2);}
| fact MUL fact {fprintf(ans, "%s\n", $2);}
| fact DIV fact {fprintf(ans, "%s\n", $2);}
| ID ASSIGN fact
| ID {fprintf(ans, "Variable ID: %s\n", $1);}
| NUM {fprintf(ans, "Val: %d\n", $1);}
| STRING {fprintf(ans, "String VAL: %s\nExpression ends\n", $1);}
| token
| func_call {fprintf(ans, "Funtion call\n");}
| SUB fact {fprintf(ans, "%s\n", $1);}
| L_PAREN fact R_PAREN

%%
int yyerror(char *msg){
    printf("Error\n");
    fprintf(ans, "Error! Parsing Terminated\n");
    return -1;
}

int main(int argc, char* argv[]){
    if(argc<=1){
        printf("No input source given\n");
        return 0;
    }
    out = fopen("lexer.txt", "w");
    ans = fopen("parser.txt", "w");
    freopen(argv[1], "r", stdin);
    yyparse();
    fclose(ans);
    return 0;
}

