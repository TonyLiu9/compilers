#ifndef TREE_H
#define TREE_H
#include <bits/stdc++.h>

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
    NODE_VAR,
    NODE_FUNC,
    NODE_ASSIGN,
    NODE_STRDEF
};

enum VarFlag
{
    VAR_COMMON,
    VAR_ADDRESS,
    VAR_POINTER
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
    OP_ADD,
    OP_MINUS, 
    OP_MULTI, 
    OP_DIV, 
    OP_MOD,
    OP_SADD, 
    OP_SMIN, 
    OP_NEG, 
    OP_POS,
    OP_NOT, 
    OP_AND, 
    OP_OR,
    OP_EQ, 
    OP_LT, 
    OP_LE, 
    OP_GT, 
    OP_GE,
    OP_NE
};


enum VarType{
    VAR_VOID,
    VAR_BOOLEAN,
    VAR_INTEGER,
    VAR_CHAR,
    VAR_STR
};
class TreeNode {
public:
    TreeNode(int NodeType);
    int nodeID;
    NodeType nodeType;

    TreeNode *child = nullptr;
    TreeNode *sibling = nullptr;

    void addChild(TreeNode *);
    void addSibling(TreeNode *);

    void getNodeId();//从根节点开始逐个赋Id 实现方式同学们可以自行修改
    TreeNode* getChlid(int index);
    int childnum();
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
    string str_val;
    int stmtType;
    int opType;
    int varType;
    string var_name;
    int varFlag;
    TreeNode(NodeType type);
private:
    vector<TreeNode *> CHILDREN;
    vector<TreeNode *> SIBLING;

};
#endif