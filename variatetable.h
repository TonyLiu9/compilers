#include<bits/stdc++.h>
using namespace std;


class variate
{
public:
    int type;
    string name;
    int int_val;
    string str_val;
    variate()
    {
        this->type = 0;
        this->name = "";
    }
    variate(int type, string name)
    {
        this->type = type;
        this->name = name;
    }
};
class tmpvariate
{
public:
    variate v;
    int l;
    tmpvariate(variate v, int l)
    {
        this->v = variate(v.type, v.name);
        this->l = l;
    }
};
