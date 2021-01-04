#ifndef TREE_H
#define TREE_H
#include<iostream>
#include<string>

using namespace std;
enum NodeType{
    NODE_PROG,
    NODE_STMT,
    NODE_OP,
    NODE_TYPE,
    NODE_BOOL,
    NODE_CONINT,
    NODE_CONCHAR,
    NODE_CONSTR,
    NODE_FEXPR,
    NODE_WEXPR,
    NODE_VAR,
    NODE_FUNC,
    NODE_ASSIGN,
    NODE_STRDEF
};

enum StmtType{
    STMT_IF,
    STMT_WHILE,
    STMT_FOR,
    STMT_DECL,
    STMT_ASSIGN,
    STMT_PRINTF,
    STMT_SCANF
};

enum OpType{
    OP_ADD, OP_MINUS, OP_MULTI, OP_DIV, OP_MOD,
    OP_SADD, OP_SMIN, OP_NEG, OP_POS,
    OP_NOT, OP_AND, OP_OR,
    OP_EQ, OP_LT, OP_LE, OP_GT, OP_GE, OP_NE
};

enum VarType{
    VAR_VOID,
    VAR_BOOLEAN,
    VAR_INTEGER,
    VAR_CHAR,
    VAR_STR
};
struct msym{
    int snum;
    char*  sym;
};
struct TreeNode {
    int nodeID;
    NodeType nodeType;

    TreeNode *child = nullptr;
    TreeNode *sibling = nullptr;

    void addChild(TreeNode *);
    void addSibling(TreeNode *);

    void genNodeId();//从根节点开始逐个赋Id 实现方式同学们可以自行修改

    void printAST();//打印语法树结点
    /***
     * 以下的几个函数皆为在printAST过程中辅助输出使用
     * 同学们可以根据需要自己使用其他方法
    ***/
    void printNodeInfo();
    void printNodeConnection();
    string nodeTypeInfo();

    int int_val;
    bool bool_val;
    StmtType stmtType;
    OpType opType;
    VarType varType;
    string var_name;

    TreeNode(NodeType type);

};
};
#endif