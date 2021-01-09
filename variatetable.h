#pragma once
#include<string>
#include<vector>
using namespace std;
class variate
{
public:
    int type;
    string name;
    int ro_index;
    vector<int> dim;
    variate()
    {
        this->type = 0;
        this->name = "";
    }
    variate(const variate& v)
    {
        this->type = v.type;
        this->name = v.name;
    }
    variate(int type, string name)
    {
        this->type = type;
        this->name = name;
    }
    variate(string name, int ro_index)
    {
        this->type = 4;
        this->ro_index = ro_index;
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
class scope
{
public:
    vector<variate> varies;
    int index;
    void output()
    {
        for(int i = 0;i < varies.size();i++)
        {
            printf("%s  %d\n", varies[i].name.c_str(), index);
        }
    }
    scope(vector<variate> varies, int index)
    {
        this->varies = varies;
        this->index = index;
    }
};
