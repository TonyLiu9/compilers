%option noyywrap
%top{
#include<fstream>
#include<map>
#include<iomanip>
#include<stdio.h>
#include<string.h>
#include <cstring>
#include <stdlib.h>
#include <iostream>
using namespace std;
}
%{
int chars=0,words=0,lines=0,numbers=0,mem=0,todo=0,count=0,i=0,jdgf=0,jdgb=0,jdgp=0,ckmc=0,csymj=0;
char *remf,*sye[100],*ckm;
char strings[100],sc[100][100],scc[100][100];
struct msym{
    int snum;
    char*  sym;
};
msym b[256];
void initm(msym* a)
{
	for(int i=0;i<256;i++){
        a[i].sym=new char[15];
        a[i].sym[0]='0';
        a[i].sym[1]='\0';}
}
int symj(char* text,int l)
{
int sji=0;
sJ:if(strcmp(b[sji].sym,"0")==0)
{
	strcpy(b[sji].sym,text);
	csymj++;
	return sji;
}
else
{
	if(strcmp(b[sji].sym,text)==0)
	{
		return sji;
	}
	else
	{
		sji=(++sji)%256;
		goto sJ;
	}
}
}
%}

while	while
int	int
if	if
return	return
lbrase	"{"
rbrase	"}"
lbracket	"["
rbracket	"]"
lparen	"("
rparen	")"
smaller "<"
bigger ">"
semicolon	;
eq	==
assign	=
number	[1-9][0-9]*|[0]
word	[a-zA-Z]+
add	"+"
minus	"-"
sub	"*"
div	"/"
line	\n
char	.
cb "//".*\n
commentbegin "/*" 
commentelement .|\n
commentend "*/" 
%x COMMENT
%%
{return}	{std::cout<<std::setw(10)<<"RETURN"<<std::setw(10)<<"return"<<std::endl;}
{lbrase}	{std::cout<<std::setw(10)<<"LBRASE"<<std::setw(10)<<"{"<<std::endl;}
{rbrase}	{std::cout<<std::setw(10)<<"RBRASE"<<std::setw(10)<<"}"<<std::endl;}
{lbracket}	{std::cout<<std::setw(10)<<"LBRACKET"<<std::setw(10)<<"["<<std::endl;}
{rbracket}	{std::cout<<std::setw(10)<<"RBRACKET"<<std::setw(10)<<"]"<<std::endl;}
{lparen}	{std::cout<<std::setw(10)<<"LPAREN"<<std::setw(10)<<"("<<std::endl;ckmc++;}
{rparen}	{std::cout<<std::setw(10)<<"RPAREN"<<std::setw(10)<<")"<<std::endl;ckmc++;
if(ckmc==4){
std::cout<<"in fanction/main last id"<<std::endl;}
}
{eq}	{std::cout<<std::setw(10)<<"EQ"<<std::setw(10)<<"=="<<std::endl;}
{smaller}	{std::cout<<std::setw(10)<<"SMT"<<std::setw(10)<<"<"<<std::endl;}
{bigger}	{std::cout<<std::setw(10)<<"BIGT"<<std::setw(10)<<">"<<std::endl;}
{number}	{
		 numbers++;chars+=strlen(yytext);
		 std::cout<<std::setw(10)<<"NUMBER"<<std::setw(10)<<yytext<<std::setw(10)<<yytext<<std::endl;
		 /*if(todo==0)
		mem=int(*yytext)-48;
		 else if(todo==1)
		 mem=mem+int(*yytext)-48;
		 else if(todo==2)
		 mem=mem-int(*yytext)+48;
		 else if(todo==3)
		 mem=mem*(int(*yytext)-48);
		 else if(todo==4)
		 mem=mem/(int(*yytext)-48);
		 todo=0;*/
		}
{assign}	{std::cout<<std::setw(10)<<"ASSIGN"<<std::setw(10)<<"="<<std::endl;}
{while}	{std::cout<<std::setw(10)<<"WHILE"<<std::setw(10)<<"while"<<std::endl;}
{semicolon}	{std::cout<<std::setw(10)<<"SEMICOLON"<<std::setw(10)<<";"<<std::endl;ckmc=5;}
{int}	{std::cout<<std::setw(10)<<"INT"<<std::setw(10)<<"int"<<std::endl;ckmc=1;}
{if}	{std::cout<<std::setw(10)<<"IF"<<std::setw(10)<<"if"<<std::endl;}
{commentbegin} {BEGIN COMMENT;}
{cb} {}
<COMMENT>{commentelement}	{}
<COMMENT>{commentend}	{BEGIN INITIAL;}
{line}	{lines++;}
{div}	{std::cout<<std::setw(10)<<"DIV"<<std::setw(10)<<"/"<<std::endl;todo=4;}
{sub}	{std::cout<<std::setw(10)<<"SUB"<<std::setw(10)<<"*"<<std::endl;todo=3;}
{minus}	{std::cout<<std::setw(10)<<"MINUS"<<std::setw(10)<<"-"<<std::endl;todo=2;}
{add}	{std::cout<<std::setw(10)<<"ADD"<<std::setw(10)<<"+"<<std::endl;todo=1;}

{word}	{ words++;
/*if(ckmc==0)
	 ckm=yytext;*/
	 /*ckmc++;
	chars+=strlen(yytext);
	 strncpy(strings,yytext,10);
	 strings[10]='/0';
	 count=0;
	 for(;count<i;count++)
	 {
		strncpy(scc[count],strings,10);
	 	scc[count][10]='/0';
	 	/*std::cout<<"try"<<std::endl;*/
	 	/*for(int ac=0;ac<10;ac++)
	 	{
	 	if(sc[count][ac]!=scc[count][ac])
	 	{jdgp++;}
		if(jdgp==0)
	 	{	std::cout<<std::setw(10)<<"ID"<<std::setw(10)<<yytext<<std::setw(10)<<count<<std::endl;
	 	goto L;
	 	}
	 	}
	 }
	G: if(count==i)
	 {
	 /*std::cout<<"addmore"<<std::endl;*/
	 /*strncpy(sc[i],strings,10);
	 sc[i][10]='/0';
	 std::cout<<std::setw(10)<<"ID"<<std::setw(10)<<yytext<<std::setw(10)<<i<<std::endl;

	 i++;
	 }
	 L:;//sleep
	 */
	 std::cout<<std::setw(10)<<"ID"<< std::setw(10)<<yytext<<std:: setw(10)<<symj(yytext,yyleng)<<std::endl;
	}
{char}	{chars++;}
%%
