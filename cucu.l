%{
    #include "cucu.tab.h"
    #include <string.h>
    #include <stdio.h>
    // extern int yylval;
    FILE* out;
%}
%%
"if" {
    fprintf(out, "IF : %s\n", yytext);
    return IF;
}

"else" {
    fprintf(out, "ELSE : %s\n", yytext);
    return ELSE;
}
"while" {
    fprintf(out, "WHILE : %s\n", yytext);
    return WHILE;
}
"return" {
    fprintf(out, "RETURN : %s\n", yytext);
    return RETURN;
}

"int" {
    fprintf(out, "TYPE_INT : %s\n", yytext);
    yylval.str=strdup(yytext);
    return TYPE_INT;
}
"char *" {
    fprintf(out, "TYPE_STRING : %s\n", yytext);
    yylval.str=strdup(yytext);
    return TYPE_STRING;
}
"char*" {
    fprintf(out, "TYPE_STRING : %s\n", yytext);
    yylval.str=strdup("char *");
    return TYPE_STRING;
}
[0-9]+ {
    fprintf(out, "NUM : %s\n", yytext);
    yylval.num=atoi(yytext);
    return NUM;
}
\".*\" {
    fprintf(out, "STRING : %s\n", yytext);
    yylval.str=strdup(yytext);
    return STRING;
}
[a-zA-Z][a-zA-Z0-9_]* {
    fprintf(out, "ID : %s\n", yytext);
    yylval.str=strdup(yytext);
    return ID;
}
"+" {
    fprintf(out, "ADD : %s\n", yytext);
    yylval.str=strdup(yytext);
    return ADD;
}
"-" {
    fprintf(out, "SUB : %s\n", yytext);
    yylval.str=strdup(yytext);
    return SUB;
}
"*" {
    fprintf(out, "MUL : %s\n", yytext);
    yylval.str=strdup(yytext);
    return MUL;
}
"/" {
    fprintf(out, "DIV : %s\n", yytext);
    yylval.str=strdup(yytext);
    return DIV;
}
"(" {
    fprintf(out, "L_PAREN : %s\n", yytext);
    return L_PAREN;
}
")" {
    fprintf(out, "R_PAREN : %s\n", yytext);
    return R_PAREN;
}
"{" {
    fprintf(out, "L_CURL : %s\n", yytext);
    return L_CURL;
}
"}" {
    fprintf(out, "R_CURL : %s\n", yytext);
    return R_CURL;
}
"[" {
    fprintf(out, "L_SQ : %s\n", yytext);
    return L_SQ;
}
"]" {
    fprintf(out, "R_SQ : %s\n", yytext);
    return R_SQ;
}

";" {
    fprintf(out, "SEMI : %s\n", yytext);
    return SEMI;
}
"," {
    fprintf(out, "COMMA : %s\n", yytext);
    return COMMA;
}
"<=" {
    fprintf(out, "LTQ : %s\n", yytext);
    yylval.str=strdup(yytext);
    return LTQ;
}
">=" {
    fprintf(out, "GTQ : %s\n", yytext);
    yylval.str=strdup(yytext);
    return GTQ;
}
"<" {
    fprintf(out, "LT : %s\n", yytext);
    yylval.str=strdup(yytext);
    return LT;
}
">" {
    fprintf(out, "GT : %s\n", yytext);
    yylval.str=strdup(yytext);
    return GT;
}
"==" {
    fprintf(out, "EQ : %s\n", yytext);
    yylval.str=strdup(yytext);
    return EQ;
}

"!=" {
    fprintf(out, "NEQ : %s\n", yytext);
    yylval.str=strdup(yytext);
    return NEQ;
}
"=" {
    fprintf(out, "ASSIGN : %s\n", yytext);
    yylval.str=strdup(yytext);
    return ASSIGN;
}
"&" {
    fprintf(out, "AND : %s\n", yytext);
    yylval.str=strdup(yytext);
    return AND;
}
"|" {
    fprintf(out, "OR : %s\n", yytext);
    yylval.str=strdup(yytext);
    return OR;
}
"^" {
    fprintf(out, "XOR : %s\n", yytext);
    yylval.str=strdup(yytext);
    return XOR;
}

\/\/.* {
    fprintf(out, "COMMENT : %s\n", yytext);
    }
\/\*[^*]*[*]+([^/][^*]*[*]+)*\/  {
    fprintf(out, "COMMENT : %s\n", yytext);
    }
[ ]+ ;
[\n]+ ;

%%
int yywrap(){
    return 1;
}

// int main(int argc, char *argv[]){
//     yyin = fopen(argv[1], "r");
//     // yyout = fopen(argv[2], "w");
//     out = fopen(argv[2], "w");
//     yylex();
//     // printf("The number of comments = %d\n", cnt);
//     return 0;
// }