// Prime Powered XOR Crypter Test
// Paw Petersen, SLAE-656
// https://www.pawpetersen.dk/slae-assignment-7-prime-powered-xor-crypter-linux-x86/

#include <stdio.h>
#include <string.h>

int key = 73698503;
unsigned char code[] = \
  "\xaf\x96\xca\xfd\xf7\x51\x32\x22\x21\x08\x0d\xfd\xc8\xc5"
  "\xe9\xa3\x8c\xa3\x6e\x33\x76\x9a\xd4\x72\x2e\x3d\x98\x8a"
  "\xf2\xb1\x91\xe2\x1f\xb9\x73\x66\xfa\x93\x12\x5b\x8b\xac"
  "\xc1\x9f\xad\xe6\xed\xc3\xaf\x8c\xec\xca\x3f\xaa\x65\x28"
  "\xda\x7b\x49\x88\x64\xe6\xc5\xa3\x24\x8c\xcf\x62\x95\xc3"
  "\xdd\x06\xcd\xbf\xa5\x82\x72\x22\x77\xe6\xf5\x24\x91\xe9"
  "\x60\x5c\xae\xc8\x84\xae\x69\x05\xcb\x14\x67\x1c\x29";

int isPrime(unsigned int n){
  unsigned int i;
  for(i=2;i<=n/2;++i)
    if(n%i==0)
      return 0;
  return 1;
}

int main()
{
  int code_len = strlen(code);
  int i = 0;
  for(key; key < 0xffffffff; key++){
    if(isPrime(key)){
      code[i] = (0xff&key)^code[i];
      i++;
      if(i >= code_len)
        break;
    }
  }
  int (*ret)() = (int(*)())code;
  ret();
  return 0;
}
