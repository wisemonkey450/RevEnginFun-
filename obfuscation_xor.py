import binascii as bs
import os
import sys


if len(sys.argv) < 2:
    print "You need to give me something dude!"
    exit(-1)
#CHANGE THIS
var = sys.argv[1]
#RANDO KEY
key = os.urandom(len(var))

enc = [ chr(ord(a) ^ ord(b)) for (a,b) in zip(var, key) ]
dec = [ chr(ord(a) ^ ord(b)) for (a,b) in zip(enc, key) ]
pkey = [ chr(ord(a) ^ ord(b)) for (a,b) in zip(enc, dec) ]


print "You can insert these value as byte array for C. Please make sure to use the proper syntax or bad things will happen."


sys.stdout.write("int hehe[%d] = " % len(var))
#print enc
count = 0
sys.stdout.write("{")
for val in enc:
    sys.stdout.write(hex(ord(val)))
    if count != len(enc)-1:
        sys.stdout.write(",")
    count = count + 1

sys.stdout.write("};")
print
#print pkey

sys.stdout.write("int haha[%d] = " % len(var))
count = 0
sys.stdout.write("{")
for val in pkey:
    sys.stdout.write(hex(ord(val)))
    if count != len(enc)-1:
        sys.stdout.write(",")
    count = count + 1

sys.stdout.write("};")
print
#print [ chr(ord(a) ^ ord(b)) for (a,b) in zip(enc, pkey) ]
