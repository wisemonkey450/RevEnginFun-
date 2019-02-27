#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>
#include <getopt.h>

#ifndef _PARSEARGS
#define _PARSEARGS

//Default to no debug
#define DEBUG 0

//Parse the arguments
void parseargs(char **,int);
#endif
