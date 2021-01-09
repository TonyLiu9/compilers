#include<bits/stdc++.h>
#include"tree.h"
using namespace std;
class struct_def
{
public:
    string name;
    vector<variate> var;
    int struct_index;
    struct_def(string name, vector<variate> var)
    {
        this->name = name;
        this->var = var;
    }
};
static int struct_num = 4;
