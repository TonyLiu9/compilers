%{
/************************************************************
识别空白符、多位十进制整数
************************************************************/
#include <stdio.h>
#include <stdlib.h>
#ifndef YYSTYPE
#define YYSTYPE double
#endif
int yylex();
extern int yyparse();
FILE* yyin;
void yyerror(const char* s);
%}
%token NUMBER
%left '+' '-'
%left '*' '/'
%right UMINUS

%%
lines:lines expr ';' {printf("%f\n",$2);}
|lines ';'
|
;


expr 
	: expr '+' expr { $$ = $1 + $3; }
	|expr '-' expr { $$ = $1 - $3; }
	|expr '*' expr { $$ = $1 * $3; }
	|expr '/' expr { $$ = $1 / $3; }
	|'(' expr ')' { $$ = $2; }
	|'-' expr %prec UMINUS {$$=-$2;}
	|NUMBER{$$=$1;}
	;
%%
// programs section
int yylex()
{
int t;
while(1)
{
t=getchar();
if(t==' '||t=='\t'||t=='\n')
{
//go asleep silently
//unaware of \n
}
else
if(isdigit(t))
{
yylval=0;
while(isdigit(t))
{
yylval=yylval*10+t-'0';
t=getchar();
}
ungetc(t,stdin);
return NUMBER;
}
else
{
return t;
}
}
}
int main(void)
{
yyin = stdin;
do {
yyparse();
} while(!feof(yyin));
return 0;
}
void yyerror(const char* s) {
fprintf(stderr,"Parse error:%s\n",s);
exit(1);
}
