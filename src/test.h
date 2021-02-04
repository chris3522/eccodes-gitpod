
#ifndef test_H
#define test_H

#define CHECK(a, msg) test2(#a , a, msg)

int test1(const char*);

void test2(const char*, int , const char* );

#endif