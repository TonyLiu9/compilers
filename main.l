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
word	[a-zA-Z][0-9a-zA-Z]*
addword [\&][a-zA-Z][0-9a-zA-Z]*
ptrofword	[\*][a-zA-Z][0-9a-zA-Z]*
CHARACTER \'(.*)\'
STRING \"(.*)\"
add	"+"
minus	"-"
sub	"*"
div	"/"
line	\n
cb "//".*\n
commentbegin "/*" 
commentelement .|\n
commentend "*/" 
char	.
%x COMMENT
%%
{return}	{return RETURN;}
{lbrase}	{return LBRASE;}
{rbrase}	{return RBRASE;}
{lbracket}	{return LBRACKET;}
{rbracket}	{return RBRACKET;}
{lparen}	{return LPAREN;ckmc++;}
{rparen}	{return RPAREN;ckmc++;}
{eq}	{return EQUAL;}
{smaller}	{return SMT;}
{bigger}	{return BIGT;}
">=" return BTOE;
"<=" return STOE;
{number}	{
		 numbers++;chars+=strlen(yytext);

    TreeNode *node = new TreeNode(NODE_CONINT);
    node->int_val = atoi(yytext);
    yylval = node;
		 return NUMBER;
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
		{number8}{
TreeNode *node = new TreeNode(NODE_CONINT);
    node->int_val = otoi(yytext);
    yylval = node;
		 return NUMBER;
		}
		{number16}{

    TreeNode *node = new TreeNode(NODE_CONINT);
    node->int_val = htoi(yytext);
    yylval = node;
    	
		 return NUMBER;
		}
		{CHARACTER} {
    TreeNode *node = new TreeNode(NODE_CONCHAR);
    node->int_val = int(string(yytext)[1]);
    yylval = node;
    return CHARACTER;
}
{STRING} {
    TreeNode *node = new TreeNode(NODE_CONSTR);
    string str = string(yytext);
    str.erase(0,str.find_first_not_of("\""));
    str.erase(str.find_last_not_of("\"") + 1);
    node->str_val = str;
    yylval = node;
    return STRING;
}
{assign}	{return ASSIGN;}
{while}	{return WHILE;}
{semicolon}	{return SEMICOLON;ckmc=5;}
{int}	{ckmc=1;return INT;}
"void"	{ckmc=1;return VOID;}
"struct"{return STRUCT;}
"else" return ELSE;
"printf" return PRINTF;
"scanf" return SCANF;

"const" return CONST;

"." return DOT;
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
"++" return SELFADD;
"--" return SELFMIN;
"+=" return ADDASS;
"-=" return MINASS;
"/=" return DIVASS;
"*=" return SUBASS;
"%=" return MODASS;
"!=" return NEQUAL;
"%" return MOD;
"!" return NOT;
"&&" return AND;
"||" return OR;
"," return COMMA;
{word}	{ words++;
    TreeNode *node = new TreeNode(NODE_VAR);
    node->varName = string(yytext);
    yylval = node;
    return WORD;}
    {addword}	{ words++;
    TreeNode *node = new TreeNode(NODE_VAR);
    string str = string(yytext);
    str.erase(str.begin());
    node->varName = str;
    node->varFlag = VAR_ADDRESS;
    yylval = node;
    return WORD;}
    {ptrofword}	{ words++;
    TreeNode *node = new TreeNode(NODE_VAR);
    string str = string(yytext);
    str.erase(str.begin());
    node->varName = str;
    node->varFlag = VAR_POINTER;
    yylval = node;
    return WORD;}
{char}	{chars++;}
%%
