#! /usr/bin/env python

import binascii as bs
import os
import sys
import time
import random
import string

class bc:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

def print_debug(mess):
    print bc.HEADER + "[ " + time.asctime( time.localtime(time.time()) )+ " ] " + bc.ENDC + bc.OKBLUE + mess + bc.ENDC

def init_file(fd, name):
    fd.write("#ifndef _%s\n" % name.replace(".h",""))
    fd.write("#define _%s\n\n\n" % name.replace(".h", ""))
    fd.write("/* AUTOGENERATED FILE --- IT IS UNWISE TO MODIFY*/\n")
    fd.write("#include <stdio.h>\n")
    fd.write("#include <stdlib.h>\n")
    fd.write("#include <stdint.h>\n")
    fd.write("#include <unistd.h>\n")
    fd.write("\n\n")

def init_c_file(header):
    c_file = header.split(".")[0] + ".c"
    fd = open(c_file, "a+")
    fd.write("/* AUTOGENERATED FILE --- IT IS UNWISE TO MODIFY*/\n")
    fd.write("#include \"%s\"\n\n" % header)
    return fd

def gen_decode_func(fd, cmd, real_cmd):
    #Function declaration
    fd.write("//This function will return %s when xored\n" % cmd)
    fd.write("char *decode_print_%s(){\n" % cmd)
    fd.write("\tchar *decoded = (char*)malloc(sizeof(char) * %d);\n" % (len(real_cmd)))
    fd.write("\tfor(int i = 0; i < %d; i++){\n" % (len(real_cmd)))
    fd.write("\t\tdecoded[i] = %s_1[i] ^ %s_2[i];\n" % (cmd, cmd))
    fd.write("\t}\n")
    fd.write("\treturn decoded;\n")
    fd.write("}\n\n")

def gen_xor(fd, filename, cmd_comma_list):
    cmd_list = cmd_comma_list.split(',')
    cfd = init_c_file(filename)

    for cmd in cmd_list:
<<<<<<< HEAD
        fd.write("//The %s command\n" % cmd)
        #Rando key
=======
        cmd_name = str(cmd.split(" ")[0]) + str("_") + str(''.join(random.choice(string.ascii_lowercase + string.digits) for _ in range(5)))

        print_debug(cmd_name)

        #RANDO KEY
>>>>>>> 6d3d28184f20b9002740ca94561954192fde56ec
        key = os.urandom(len(cmd))

        enc = [ chr(ord(a) ^ ord(b)) for (a,b) in zip(cmd, key) ]
        dec = [ chr(ord(a) ^ ord(b)) for (a,b) in zip(enc, key) ]
        pkey = [ chr(ord(a) ^ ord(b)) for (a,b) in zip(enc, dec) ]

        cfd.write("int %s_1[%d] = " % (cmd_name, len(cmd)))

        count = 0
        cfd.write("{")
        for val in enc:
            cfd.write(hex(ord(val)))
            if count != len(enc)-1:
                cfd.write(",")
            count = count + 1

        cfd.write("};")

        cfd.write("\n")

        cfd.write("int %s_2[%d] = " % (cmd_name, len(cmd)))
        count = 0
        cfd.write("{")
        for val in pkey:
            cfd.write(hex(ord(val)))
            if count != len(enc)-1:
                cfd.write(",")
            count = count + 1

        cfd.write("};")
        cfd.write("\n\n\n")
        gen_decode_func(cfd, cmd_name, cmd)
        fd.write("//Function that will decode the above strings\n")
        fd.write("char * decode_print_%s();\n\n" % cmd_name)
    cfd.close()

def main():
    if len(sys.argv) < 2:
        print "You need to give me something dude!"
        exit(-1)

    files = list(sys.argv[1:])
    print_debug("Will be writing to the following files: " + str(files))

    #Make seperate directory
    try:
        print_debug("Making headers directory")
        os.mkdir("headers")

    #headers already exists...
    except OSError:
<<<<<<< HEAD
        print_debug("Header Directory appears to exist")
        pass
=======
        print_debug("Reinitializing the headers directory")
        os.system('rm -rf headers')
        print_debug("Making headers directory")
        os.mkdir("headers")
>>>>>>> 6d3d28184f20b9002740ca94561954192fde56ec

    #Change to that directory
    print_debug("Changing into headers directory")
    os.chdir("./headers")

    for filename in files:
        fd = open(filename, "w")
        #Include files
        init_file(fd, filename)
        print_debug("File " + str(filename) + " has been initialized")

        #Commands to include
        cmd = raw_input("Give me commands in a comma seperated list format to XOR >>")
        cmds = cmd.split(',')
        print_debug("XORing those commands")
        gen_xor(fd, filename, cmd)
        fd.write("#endif /* _%s */\n" % filename)
        fd.close()

        #Print Debug stuff
        print_debug("Wrote " + str(cmds) + " to " + filename)
        print_debug("Closed File: " + filename)

if __name__ == "__main__":
    main()
