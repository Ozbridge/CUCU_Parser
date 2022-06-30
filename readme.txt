RISHABH JAIN    2020CSB1198

Assumptions:
1)  Statement block cannot be empty. For example:

    if(a==b){
        int x;
    }

    This is valid.

    if(a==b){

    }

    This is invalid.

2)  Data types are strictly limited to int annd char *. char ** or int * are invalid.

3)  Expressions are shown in postfix format.

4)  Operations between any tokens (even int and char*) are allowed as this does not deal with semantics.

5)  As soon as an error is encountered parsing and tokenization stops immediately.

6)  Only one variable can be declared or initialised at a time.

7)  Ambiguous else always gets attached to closest if statement.

8)  The valid statements are limited to assignment, if, if-else, while, return and ;

9)  Comments will be ignored in the parser.

10)  Assignment within expressions is considered invalid. (For eg: int a = b=5; This will be considered invalid)

Commands:

bison -d cucu.y
flex cucu.l
g++ cucu.tab.c lex.yy.c -lfl -o cucu
./cucu Sample1.cu
./cucu Sample2.cu	

** Sample1.cu is valid, Sample2.cu is not.

