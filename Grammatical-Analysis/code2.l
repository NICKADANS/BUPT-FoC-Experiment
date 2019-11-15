%{
	#include <stdlib.h>
	#include "code3.tab.h"
	extern void yyerror(char *s);
%}

%%
[" ";\t]					{ }
(0(\.[0-9]+)?)|([1-9][0-9]*(\.[0-9]+)?)		{ yylval.val = strtod(yytext,NULL); return DIGIT;}
[-+*/()\n] 					{ return *yytext;}
%%
int yywrap(){
	return 1;
}
