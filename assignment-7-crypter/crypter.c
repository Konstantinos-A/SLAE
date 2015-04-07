// Prime Powered XOR Crypter
// Paw Petersen, SLAE-656
// https://www.pawpetersen.dk/slae-assignment-7-prime-powered-xor-crypter-linux-x86/

#include <stdio.h>
#include <string.h>
#include <time.h>
#include <stdlib.h>

#define LOWER_BOUND 50000000
#define UPPER_BOUND 100000000

unsigned char code[] = \
  "\x68\x73\x21\x0a\x0a\x68\x77\x6f\x72\x6b\x68\x74\x65\x72"
  "\x20\x68\x43\x72\x79\x70\x31\xc9\xb1\x0f\x51\xb8\x11\x11"
  "\x51\x08\x50\x31\xc0\x50\x54\x51\x89\xe6\x83\xc6\x14\x03"
  "\x74\x24\x10\x2b\x34\x24\x56\x89\xf1\xeb\x1c\xeb\x0c\x59"
  "\x59\xe2\xe8\x31\xdb\x31\xc0\xb0\x01\xcd\x80\x31\xc0\xb0"
  "\xa2\x8d\x5c\x24\x0c\x31\xc9\xcd\x80\xeb\xe6\x31\xd2\xb2"
  "\x01\x31\xdb\xb3\x01\x31\xc0\xb0\x04\xcd\x80\xeb\xd4";

int isPrime(unsigned int n){
  unsigned int i;
  for(i=2;i<=n/2;++i)
    if(n%i==0)
      return 0;
  return 1;
}

int getRand(unsigned int lowerBound, unsigned int upperBound){
  srand(time(NULL));
  return lowerBound + rand() % (upperBound - lowerBound);
}

int main()
{
  int code_len = strlen(code);
  int i = 0;
  unsigned int key = getRand(LOWER_BOUND,UPPER_BOUND);
  printf("int key = %u;\n",key);
  printf("unsigned char code[] = \\\n\"");
  for(key; key < 0xffffffff; key++){
    if(isPrime(key)){
      unsigned char crypted_byte = (0xff&key)^code[i];
      printf("\\x%02x", crypted_byte);  
      i++;
      if(i >= code_len)
        break;
    }
  }
  printf("\";\n");
  return 0;
}
