#include <stdio.h>
#include <stdlib.h>

#include "test.h"

int test1(const char* prog) {
    printf("test4:  affiche %s et return 12\n",prog);
    return 12;
}

void test2(const char* call, int e, const char* msg) {
    printf("test2: func is %s, code is %d, msg is %s\n",call, e,msg);
}

