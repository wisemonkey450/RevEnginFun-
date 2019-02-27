#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdint.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>

#include "color_names.h"
#include "hexdump.h"
#include "parseargs.h"

COLOR_MBR = 0;

void usage(){
    printf("./readmbr <FILENAME> [OPTIONS]\n");
    printf("Author: John C Geenty III <wisemonkey450>\n");
    printf("Options list: \n\
            -h --help\tPrint this message\n\
            -a --all\tPrint all section of the MBR as a hexdump\n\
            -c --color\tPrint with colors\n\
            -C --check\tCheck and Analyze the MBR for possible errors\n");
    exit(-1);
}

//Main handler function
int main(int argc, char ** argv){
    if(argc < 2){
        usage();
    }
    //int len = strlen(*argv);
    //char ** argv_2 = (*argv + len);
    char * filename = argv[argc-1];
    parseargs(argv, argc-1);

    //Read the file into a void*, then
    //pass both the length and void* to
    //hexdump...Read in 16 blocks at a 
    //time
    int fd;
    if((fd = openat(AT_FDCWD, filename, O_RDONLY)) < 0){
        perror("Open");
        exit(-1);
    }
    void * buffer = malloc(sizeof(char) * 512);
    if(!buffer){
        perror("malloc");
        exit(-1);
    }

    int num_bytes_read;
    int offset = 0;
    while((num_bytes_read = read(fd, (buffer + offset), 1)) != 0){
        //lseek(fd, 1, SEEK_CUR);
        offset += 1;
    }
    printf("\n");
    hexdump("Master Boot Record", buffer, 512);
    free(buffer);
}
