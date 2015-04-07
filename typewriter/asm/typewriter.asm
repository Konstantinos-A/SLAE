; Typewriter Shellcode
; Paw Petersen, SLAE-656
; https://www.pawpetersen.dk/typewriter-shellcode-generator-linux-x86/

section .text
global _start		

_start:
	push	0x0a646c72
	push	0x6f77206f
	push	0x6c6c6548	

	xor		ecx,ecx
	mov		cl,12	
	push	ecx

	mov		eax,0x08511111 ; tv_usec
	push	eax
	xor		eax,eax					; tv_sec
	push	eax
	push	esp	; push pointer
loop:	
	push	ecx
	mov		esi,esp
	add		esi,20
	add		esi,[esp+16]
	sub		esi,[esp]
	push	esi
	mov		ecx,esi
	jmp		print_c
ret1:
	jmp		sleep
ret2:
	pop		ecx	
	pop		ecx
	loop	loop

	xor		ebx,ebx
	xor		eax,eax
	mov		al,1	
	int		0x80	

sleep:
	xor		eax,eax
	mov		al, 162
	lea		ebx, [esp+12]
	xor		ecx,ecx
	int		0x80
	jmp		ret2

print_c:
	xor		edx,edx
	mov		dl,1
	xor		ebx,ebx
	mov		bl,1	
	xor		eax,eax
	mov		al,4	
	int		0x80
	jmp		ret1


