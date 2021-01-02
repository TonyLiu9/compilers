%option noyywrap
%top{
#include<common.h>
#include "main.tab.hh"
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

    
    int otoi(string s)
    {
        int ans=0;
        for(int i=1;i<s.size();i++)
            ans=ans*8+s[i]-'0';
        return ans;
    }
    int htoi(string s)
    {
        int ans=0;
        for(int i=1;i<s.size();i++)
            ans=ans*16+s[i]-'0';
        return ans;
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
number8 [0][1-9][0-9]+|[00]
number16 [0x][1-9][0-9]*|[0x0]
word	[a-zA-Z]+

CHARACTER \'(.*)\'
STRING \"(.*)\"
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
{lbrase}	{return LBRASE}
{rbrase}	{return RBRASE}
{lbracket}	{return LBRACKET}
{rbracket}	{return RBRACKET}
{lparen}	{return LPAREN;ckmc++;}
{rparen}	{return RPAREN;ckmc++;}
{eq}	{return EQUAL;}
{smaller}	{return SMT;}
{bigger}	{return BIGT;}
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
{while}	{return WHILE;}
{semicolon}	{std::cout<<std::setw(10)<<"SEMICOLON"<<std::setw(10)<<";"<<std::endl;ckmc=5;}
{int}	{ckmc=1;return INT;}
{if}	{return IF;}
{commentbegin} {BEGIN COMMENT;}
{cb} {}
<COMMENT>{commentelement}	{}
<COMMENT>{commentend}	{BEGIN INITIAL;}
{line}	{lines++;}
{div}	{return DIV;todo=4;}
{sub}	{return SUB;todo=3;}
{minus}	{return MINUS;todo=2;}
{add}	{return ADD;todo=1;}
"+=" return ADDASS;
"-=" return MINASS;
"/=" return DIVASS;
"*=" return SUBASS;
"%=" return MODASS;
"%" return MOD;
"!" return NOT;
"," return COMMA;
{word}	{ words++;
	std::cout<<std::setw(10)<<"ID"<< std::setw(10)<<yytext<<std:: setw(10)<<symj(yytext,yyleng)<<std::endl;
	}
{char}	{chars++;}
%%
