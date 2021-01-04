#include"main.tab.hh"
#include"common.h"
#include<bits/stdc++.h>
using namespace std;
TreeNode *root=nullptr;
int main ()
{
    yyparse();
    printf("@");
    if(root){
        root->getNodeId();
        root->printAST();
    }
}
int yyerror(char const* message)
{
  cout << message << endl;
  return -1;
}
