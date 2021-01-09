#include<iostream>
#include<string>
#include<vector>
#include"tree.h"
using namespace std;
class roda_part{
private:
    vector<string> ro_data;
public:
    void output();
};
class func_part{
private:
    int funcType;
    bool buf;
    vector<string> code;
    vector<string> codebuf;
    string name;
    int ret;
public:
    func_part(int ft, string fn);
    void output();
    void addCode(string _code);
    string delCode();
    void resetCode(string _code);
};