%option noyywrap
%{
    #include"common.h"
    #include"main.tab.hh"
    int firstword = 0;
    extern vector<variate> type_check;
    
    
%}

INTEGER 0|[1-9][0-9]*
CHARACTER \'(.*)\'
STRING \"(.*)\"
ID [a-zA-Z][0-9a-zA-Z]*
IDadd \&[a-zA-Z][0-9a-zA-Z]*
IDptr \*[a-zA-Z][0-9a-zA-Z]*

EOL (\r\n|\n)
WHITE [\t ]

commentbegin "/*"
commentspace [ \t]
commentelement [^ \t\n]
commentnextline \n
commentend "*/"
ALTERcomment "//"
%x LONGCOMMENT
%x SHORTCOMMENT

%%

"true" {
    TreeNode *node = new TreeNode(NODE_BOOL);
    node->bool_val = true;
    yylval = node;
    return TRUE;
}
"false" {
    TreeNode *node = new TreeNode(NODE_BOOL);
    node->bool_val = false;
    yylval = node;
    return FALSE;
}

"int" return INT;
"void" return VOID;
"char" return CHAR;

"string" return STR;
"for" return FOR;
"if" return IF;
"while" return WHILE;
"else" return ELSE;
"struct" return STRUCT;

"printf" return PRINTF;
"scanf" return SCANF;

"const" return CONST;

"." return dot;
"=" return ASSIGN;
"+=" return ADDASS;
"-=" return MINASS;
"*=" return MULASS;
"/=" return DIVASS;
"%=" return MODASS;

"++" return SELFADD;
"--" return SELFMIN;
"+" return ADD;
"-" return MINUS;
"*" return MULTI;
"/" return DIV;
"%" return MOD;

"!" return NOT;
"&&" return AND;
"||" return OR;
"==" return EQUAL;
"!=" return NEQUAL;
">" return BT;
">=" return BE;
"<" return LT;
"<=" return LE;

"," return COMMA;
";" return SEMICOLON;
"(" return LPAREN;
")" return RPAREN;
"[" return LBRACK;
"]" return RBRACK;
"{" return LBRACE;
"}" return RBRACE;






{INTEGER} {
    TreeNode *node = new TreeNode(NODE_CONINT);
    node->varType = VAR_INTEGER;
    node->int_val = atoi(yytext);
    yylval = node;
    return INTEGER;
}

{CHARACTER} {
    TreeNode *node = new TreeNode(NODE_CONCHAR);
    node->int_val = int(string(yytext)[1]);
    node->varType = VAR_CHAR;
    yylval = node;
    return CHARACTER;
}
{STRING} {
    TreeNode *node = new TreeNode(NODE_CONSTR);
    string str = string(yytext);
    str.erase(0,str.find_first_not_of("\""));
    str.erase(str.find_last_not_of("\"") + 1);
    node->str_val = str;
    node->varType = VAR_STRING;
    yylval = node;
    return STRING;
}

{ID} {
    TreeNode *node = new TreeNode(NODE_VAR);
    node->varName = string(yytext);
    vector<variate>::reverse_iterator it = type_check.rbegin();
    while(it != type_check.rend())
    {
        if((*it).name == node->varName)
        {
            node->varType = (*it).type;
            break;
        }
        it++;
    }
    yylval = node;
    return ID;
}
{IDadd} {
    TreeNode *node = new TreeNode(NODE_VAR);
    string str = string(yytext);
    str.erase(str.begin());
    node->varName = str;
    node->varFlag = VAR_ADDRESS;
    vector<variate>::reverse_iterator it = type_check.rbegin();
    while(it != type_check.rend())
    {
        if((*it).name == node->varName)
        {
            node->varType = (*it).type;
            break;
        }
        it++;
    }
    yylval = node;
    return ID;
}
{IDptr} {
    TreeNode *node = new TreeNode(NODE_VAR);
    string str = string(yytext);
    str.erase(str.begin());
    node->varName = str;
    node->varFlag = VAR_POINTER;
    vector<variate>::reverse_iterator it = type_check.rbegin();
    while(it != type_check.rend())
    {
        if((*it).name == node->varName)
        {
            node->varType = (*it).type;
            break;
        }
        it++;
    }
    yylval = node;
    return ID;
}
{EOL}
{WHITE}

{commentbegin} { BEGIN LONGCOMMENT;  }
<LONGCOMMENT>{commentelement} {  }
<LONGCOMMENT>{commentspace} {  }
<LONGCOMMENT>{commentnextline} { }
<LONGCOMMENT>{commentend} {BEGIN INITIAL; }

{ALTERcomment} { BEGIN SHORTCOMMENT; }
<SHORTCOMMENT>{commentelement} {}
<SHORTCOMMENT>{commentspace} { }
<SHORTCOMMENT>{commentnextline} { BEGIN INITIAL; }
%%