#include"main.tab.hh"
#include"common.h"
#include<bits/stdc++.h>
using namespace std;
vector<variate> type_check;
TreeNode *root=nullptr;
int main ()
{
    printf("@");
    yyparse();
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
