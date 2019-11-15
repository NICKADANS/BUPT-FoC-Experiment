%{
        #include <stdio.h>
        #include <ctype.h>
        #include <stdlib.h>
        #include <math.h>
	/* must add these function heads */
        int yylex();
        void yyerror(char *s);
%}
%union{
	double val;
}
%token <val> DIGIT
%type <val> expr term factor

%%
line:expr'\n'           {
    				printf(">>ans: %lf\n", $1);
				printf(">>program terminated.\n");
				return 0;
			}
    ;
expr:expr'+'term        {
    				printf("adopt: E->E+T\tE:%lf\tT:%lf\n", $1, $3);
    				$$=$1+$3;
			}
    |expr'-'term        {
				printf("adopt: E->E-T\tE:%lf\tT:%lf\n", $1, $3);
				$$=$1-$3;
			}
    |term               {
				printf("adopt: E->T\tT:%lf\n", $1);
				$$=$1;
			}
    ;
term:term'*'factor      {	
    				printf("adopt: T->T*F\tT:%lf\tF:%lf\n", $1, $3);
    				$$=$1*$3;
			}
    |term'/'factor      {	
				printf("adopt: T->T/F\tT:%lf\tF:%lf\n", $1, $3);
				$$=$1/$3;
			}
    |factor             {
				printf("adopt: T->F\tF:%lf\n", $1);
				$$=$1;
			}
    ;
factor:'('expr')'       {	
      				printf("adopt: F->(E)\tE:%lf\n", $2);
      				$$=$2;
			}
      |DIGIT            {
				printf("adopt: F->num\tnum:%lf\n", $1);
				$$=$1;
			}
      |'-'DIGIT		{
				printf("adopt: F->-num\tnum:%lf\n", $2);
				$$=-1*$2;
			}
      |'-''('expr')'    {
				printf("adopt: F->-(E)\tE:%lf\n", $3);
				$$=-1*$3;
			}
    ;
%%

/*
  @Author me
  @Environment Ubuntu-18.04.3, GCC, LEX(flex), YACC(bison)
  using the commands below to run code2.l and code3.y:
    flex code2.l
    bison -d code3.y
    gcc lex.yy.c code2.tab.c -lm -o test
    ./test
*/

int main(){
        yyparse();
        return 0;
}

void yyerror(char *s){
	printf("%s\n",s);
}


