#include"main.tab.hh"
#include"common.h"
#include<bits/stdc++.h>
using std::cout;
using std::endl;
using namespace std;
TreeNode *root=nullptr;
vector<struct_def> strdef;
int lid=0;
int main ()
{
    yyparse();
    if(root){//若存在语法树结点
        root->genNodeId();//将整棵语法树赋予id
        root->printAST();//打印相关信息
    }
}
int yyerror(char const* message)
{
  cout << message << endl;
  return -1;
}