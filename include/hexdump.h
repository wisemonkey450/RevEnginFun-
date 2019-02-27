//Includes for hexdump.c
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdint.h>
#include "color_names.h"

#ifndef _HEXDUMP
#define _HEXDUMP

extern int COLOR_MBR;

//Print the hexdump
void hexdump(char *, void *, int);
#endif
