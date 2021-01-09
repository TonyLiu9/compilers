#include"asm.h"
void roda_part::output()
{
    {
        int i = 0;
        for (vector<string>::iterator it = ro_data.begin(); it != ro_data.end(); it++, i++)
        {
            printf("STR%d:\n\t.string \"%s\"\n", i, (*it).c_str());
        }
    }
}

void func_part::output()
{   
    //函数开始
    printf("\n\t.text\n");
    printf("\t.globl\t%s\n", name.c_str());
    printf("\t.type\t%s, @function\n", name.c_str());
    //初始化
    printf("%s:\n", name.c_str());
    printf("\tpushl\t%%ebp\n");
    printf("\tmovl\t%%esp, %%ebp\n");
    //函数内部
    for (vector<string>::iterator it = code.begin(); it != code.end(); it++)
    {
        if(*(it) == "\tpushl\t%eax\n" && *(it+1) == "\tpopl\t%eax\n")
        {
            it += 2;
        }
        if(*(it) == "\tpushl\t%ebx\n" && *(it+1) == "\tpopl\t%ebx\n")
        {
            it += 2;
        }
        printf("%s", (*it).c_str());
    }
    //函数结束
    printf("\tpopl\t%%ebp\n");
    printf("\tmovl\t$%d, %%eax\n", ret);
    printf("\tret\n");
}
void func_part::addCode(string _code)
{
    code.emplace_back(_code);
}
string func_part::delCode()
{
    string str = code[code.size() - 1];
    code.pop_back();
    return str;
}
void func_part::resetCode(string _code)
{
    code[code.size() - 1] = _code;
}