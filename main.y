%{
    #include"common.h"
    extern TreeNode * root;
    int yylex();
    int yyerror( char const * );
    extern vector d_struct  strdef;
    bool forflag;
    vector<tempvariate> tmpfor;
    int forlevel = 0;
%}
%defines

%start program
%token RETURN
%token WORD NUMBER CHARACTER STRING WORDARR WORDPTR
%token IF ELSE WHILE FOR STRUCT
%token CONST
%token INT VOWORD CHAR 
%token LPAREN RPAREN LBRASE RBRASE LBRACKET RBRACKET COMMA SEMICOLON
%token TRUE FALSE
%token ADD MINUS SUB DIV MOD SELFADD SELFMIN
%token ASSIGN ADDEQ MINEQ MULEQ DIVEQ MODEQ
%token EQUAL NEQUAL BIGT SMT BTOE STOE NOT AND OR
%token PRINTF SCANF
%token DOT

%right OR
%right AND
%left EQUAL NEQUAL BIGT BTOE STOE SMT
%left ADD MINUS
%left SUB DIV MOD
%right NOT
%right SELFADD SELFMIN 
%right ASSIGN ADDEQ MINEQ MULEQ DIVEQ MODEQ
%nonassoc LOWER_THEN_ELSE
%nonassoc ELSE 
%%

program
    : statements {root=new TreeNode(NODE_PROG);root->addChild($1);}
    ;
statements
    : statement {$$=$1;}
    | statements statement{$$=$1;$$->addSibling($2);}
    ;
statement
    : instruction {$$=$1;}
    | if_else {$$=$1;}
    | while {$$=$1;}
    | for {$$=$1;}
    | LBRACE statements RBRACE {$$=$2;}
    | def_func {$$=$1;}
    | printf SEMICOLON {$$=$1;}
    | scanf SEMICOLON {$$=$1;}
    | d_struct {$$=$1;}
    ;
d_struct
    : STRUCT WORD LBRACE struct_ins RBRACE args SEMICOLON
    {
        TreeNode* node = new TreeNode(NODE_STRDEF);
        node->addChild($2);
        node->addChild($4);
        int cnum = node->childNum();
        node->addChild($6);
        $$=node;
    }
    | STRUCT WORD LBRACE struct_ins RBRACE SEMICOLON
    {
        TreeNode* node = new TreeNode(NODE_STRDEF);
        node->addChild($2);
        node->addChild($4);
        $$=node;
    }
    ;
struct_ins
    : instruction {$$=$1;}
    | struct_ins instruction {$$=$1;$$->addSibling($2);}
    ;
ass
    : WORDS ASSIGN expr{
        TreeNode* node=new TreeNode(NODE_ASSIGN);
        node->addChild($1);
        node->addChild($3);
        $$=node;
    }
    | WORDS ADDASS expr{
        TreeNode* node=new TreeNode(NODE_ASSIGN);
        node->opType=OP_ADD;
        node->addChild($1);
        node->addChild($3);
        $$=node;
    }
    | WORDS MINASS expr{
        TreeNode* node=new TreeNode(NODE_ASSIGN);
        node->opType=OP_MINUS;
        node->addChild($1);
        node->addChild($3);
        $$=node;
    }
    | WORDS MULASS expr{
        TreeNode* node=new TreeNode(NODE_ASSIGN);
        node->opType=OP_MULTI;
        node->addChild($1);
        node->addChild($3);
        $$=node;
    }
    | WORDS DIVASS expr{
        TreeNode* node=new TreeNode(NODE_ASSIGN);
        node->opType=OP_DIV;
        node->addChild($1);
        node->addChild($3);
        $$=node;
    }
    | WORDS MODASS expr{
        TreeNode* node=new TreeNode(NODE_ASSIGN);
        node->opType=OP_MOD;
        node->addChild($1);
        node->addChild($3);
        $$=node;
    }
    | WORDS SELFADD {
        TreeNode *node=new TreeNode(NODE_ASSIGN);
        node->opType=OP_SADD;
        node->addChild($1);
        $$=node; 
    }
    | WORDS SELFMIN {
        TreeNode *node=new TreeNode(NODE_ASSIGN);
        node->opType=OP_SMIN;
        node->addChild($1);
        $$=node; 
    }
    ;
args
    : WORDS {$$=$1;}
    | ass {$$=$1;}
    | args COMMA WORDS {$$=$1; $$->addSibling($3);}
    | args COMMA ass {$$=$1; $$->addSibling($3);}
    ;
call_args
    : WORDS {$$=$1;}
    | WORDadd {$$=$1;}
    | WORDptr {$$=$1;}
    | call_args COMMA WORDS {$$=$1; $$->addSibling($3);}
    | call_args COMMA WORDadd {$$=$1; $$->addSibling($3);}
    | call_args COMMA WORDptr {$$=$1; $$->addSibling($3);}
    ;
def_func
    : type WORD LPAREN call_args RPAREN statement {
        TreeNode *node=new TreeNode(NODE_FUNC);
        node->addChild($1);
        node->addChild($2);
        node->addChild($4);
        node->addChild($6);
        $$=node;
    }
    | type WORD LPAREN RPAREN statement {
        TreeNode *node=new TreeNode(NODE_FUNC);
        node->addChild($1);
        node->addChild($2);
        node->addChild($5);
        $$=node;
    }
    ;
if_else
    : IF bool_statment statement %prec LOWER_THEN_ELSE {
        TreeNode *node=new TreeNode(NODE_STMT);
        node->stmtType=STMT_IF;
        node->addChild($2);
        node->addChild($3);
        $$=node;
    }
    | IF bool_statment statement ELSE statement {
        TreeNode *node=new TreeNode(NODE_STMT);
        node->stmtType=STMT_IF;
        node->addChild($2);
        node->addChild($3);
        node->addChild($5);
        $$=node;
    }
    ;
while
    : WHILE bool_statment statement {
        TreeNode *node=new TreeNode(NODE_STMT);
        node->stmtType=STMT_WHILE;
        node->addChild($2);
        node->addChild($3);
        $$=node;
    }
    ;
for
    : FORE for_expr statement{
        TreeNode *node=new TreeNode(NODE_STMT);
        node->stmtType=STMT_FOR;
        node->addChild($2);
        node->addChild($3);
        $$=node;
        while(tmpfor[tmpfor.size()-1].l == forlevel)
        {
            tmpfor.pop_back();
        }
        forlevel--;
    }
    ;
FORE
    : FOR
    {
        $$=$1;
        forflag = 1;
    }
for_expr
    : LPAREN instruction bool_expr SEMICOLON ass RPAREN{
        TreeNode *node=new TreeNode(NODE_FEXPR);
        node->addChild($2);
        node->addChild($3);
        node->addChild($5);
        $$=node;
        forlevel++;
    }
bool_statment
    : LPAREN bool_expr RPAREN {$$=$2;}
    ;
instruction
    : type args SEMICOLON {
        TreeNode *node=new TreeNode(NODE_STMT);
        node->stmtType=STMT_DECL;
        node->addChild($1);
        node->addChild($2);
        $$=node;
        int preflag = 0;
        vector<variate> l;
        for(int i = 1;i < node->childNum();i++)
        {
            TreeNode* cld = node->getChild(i);
            if(!preflag)
            {
                if(forflag) tmpfor.push_back(tmpvariate(variate($1->varType, cld->nodeType==NODE_ASSIGN?cld->getChild(0)->varName:cld->varName), forlevel));
            }
            preflag = 0;
        }
        forflag = 0;
    }
    | args SEMICOLON {
        TreeNode *node=new TreeNode(NODE_STMT);
        node->stmtType=STMT_ASSIGN;
        node->addChild($1);
        $$=node;  
    }
    | CONST type args SEMICOLON {
        TreeNode *node=new TreeNode(NODE_STMT);
        node->stmtType=STMT_DECL;
        node->addChild($2);
        node->addChild($3);
        $$=node;
        int preflag = 0;
        for(int i = 1;i < node->childNum();i++)
        {
            TreeNode* cld = node->getChild(i);
            if(!preflag)
            {
                if(forflag) tmpfor.push_back(tmpvariate(variate($1->varType, cld->nodeType==NODE_ASSIGN?cld->getChild(0)->varName:cld->varName), forlevel));
            }
            preflag = 0;
        }
        forflag = 0;
    }
    ;
printf
    : PRINTF LPAREN STRING COMMA call_args RPAREN {
        TreeNode *node=new TreeNode(NODE_STMT);
        node->stmtType=STMT_PRINTF;
        node->addChild($3);
        node->addChild($5);
        $$=node;
    }
    | PRINTF LPAREN STRING RPAREN{
        TreeNode *node=new TreeNode(NODE_STMT);
        node->stmtType=STMT_PRINTF;
        node->addChild($3);
        $$=node;
    }
    | PRINTF LPAREN WORD RPAREN{                      
        TreeNode *node=new TreeNode(NODE_STMT);
        node->stmtType=STMT_PRINTF;
        node->addChild($3);
        $$=node;
    }
    ;
scanf
    : SCANF LPAREN STRING COMMA call_args RPAREN {
        TreeNode *node=new TreeNode(NODE_STMT);
        node->stmtType=STMT_SCANF;
        node->addChild($3);
        node->addChild($5);
        $$=node;
    }
    ;
bool_expr
    : TRUE {$$=$1;}
    | FALSE {$$=$1;}
    | expr EQUAL expr {
        TreeNode *node=new TreeNode(NODE_OP);
        node->opType=OP_EQ;
        node->addChild($1);
        node->addChild($3);
        $$=node;
    }
    | expr NEQUAL expr {
        TreeNode *node=new TreeNode(NODE_OP);
        node->opType=OP_NE;
        node->addChild($1);
        node->addChild($3);
        $$=node;
    }
    | expr BIGT expr {
        TreeNode *node=new TreeNode(NODE_OP);
        node->opType=OP_BT;
        node->addChild($1);
        node->addChild($3);
        $$=node;
    }
    | expr BTOE expr {
        TreeNode *node=new TreeNode(NODE_OP);
        node->opType=OP_BE;
        node->addChild($1);
        node->addChild($3);
        $$=node;
    }
    | expr SMT expr {
        TreeNode *node=new TreeNode(NODE_OP);
        node->opType=OP_LT;
        node->addChild($1);
        node->addChild($3);
        $$=node;
    }
    | expr STOE expr {
        TreeNode *node=new TreeNode(NODE_OP);
        node->opType=OP_LE;
        node->addChild($1);
        node->addChild($3);
        $$=node;
    }
    | bool_expr AND bool_expr {
        TreeNode *node=new TreeNode(NODE_OP);
        node->opType=OP_AND;
        node->addChild($1);
        node->addChild($3);
        $$=node;
    }
    | bool_expr OR bool_expr {
        TreeNode *node=new TreeNode(NODE_OP);
        node->opType=OP_OR;
        node->addChild($1);
        node->addChild($3);
        $$=node;
    }
    | NOT bool_expr {
        TreeNode *node=new TreeNode(NODE_OP);
        node->opType=OP_NOT;
        node->addChild($2);
        $$=node;        
    }
    ;
expr
    : WORDS {$$=$1;}
    | INTEGER {$$=$1;}
    | CHARACTER {$$=$1;}
    | STRING {$$=$1;}
    | expr ADD expr {
        TreeNode *node=new TreeNode(NODE_OP);
        node->opType=OP_ADD;
        node->addChild($1);
        node->addChild($3);
        $$=node;   
    }
    | expr MINUS expr {
        TreeNode *node=new TreeNode(NODE_OP);
        node->opType=OP_MINUS;
        node->addChild($1);
        node->addChild($3);
        $$=node;   
    }
    | expr MULTI expr {
        TreeNode *node=new TreeNode(NODE_OP);
        node->opType=OP_MULTI;
        node->addChild($1);
        node->addChild($3);
        $$=node;   
    }
    | expr DIV expr {
        TreeNode *node=new TreeNode(NODE_OP);
        node->opType=OP_DIV;
        node->addChild($1);
        node->addChild($3);
        $$=node;   
    }
    | expr MOD expr {
        TreeNode *node=new TreeNode(NODE_OP);
        node->opType=OP_MOD;
        node->addChild($1);
        node->addChild($3);
        $$=node;   
    }
    | MINUS expr %prec NEG {
        TreeNode *node=new TreeNode(NODE_OP);
        node->opType=OP_NEG;
        node->addChild($2);
        $$=node; 
    }
    ;
type
    : INT {
        TreeNode *node=new TreeNode(NODE_TYPE);
        node->varType=VAR_INTEGER;
        $$=node; 
    }
    | VOWORD {
        TreeNode *node=new TreeNode(NODE_TYPE);
        node->varType=VAR_VOWORD;
        $$=node;         
    }
    | CHAR {
        TreeNode *node=new TreeNode(NODE_TYPE);
        node->varType=VAR_CHAR;
        $$=node;
    }
    ;
WORDARR
    : WORD LBRACK expr RBRACK {
        $$=$1;
        $$->dim.push_back($3);
    }
    | WORDARR LBRACK expr RBRACK {
        $$=$1;
        $$->dim.push_back($3);
    }
    ;
WORDcld
    : WORD dot WORD {
        $$=$1;
        $$->addChild($3);
    }
    | WORDARR dot WORD {
        $$=$1;
        $$->addChild($3);
    }
    | WORD dot WORDARR {
        $$=$1;
        $$->addChild($3);
    }
    | WORDARR dot WORDARR {
        $$=$1;
        $$->addChild($3);
    }
    | WORDcld dot WORD {
        $$=$1;
        $$->addChild($3);
    }
    | WORDcld dot WORDARR {
        $$=$1;
        $$->addChild($3);
    }
    ;
WORDS 
    : WORD {$$=$1;}
    | WORDARR {$$=$1;}
    | WORDcld {$$=$1;}
%%
