; x86-64 Assembly Language Programming with Ubuntu - Jorgensen, Chapter 8,
; Quiz #8

section .data

EXIT_SUCCESS equ 0
SYS_EXIT equ 60

lst dd 2, 7, 4, 5, 6, 3

section .text

global _start

_start:
    mov rbx, lst
    mov rsi, 1
    mov rcx, 2
    mov eax, 0
    ; edx = 7
    mov edx, dword [rbx+4]

MainLoop:
    ; 0:
    ;   rbx+rsi*4 = rbx+1*4 = 7
    ;   eax = 0 + 7 = 7
    ; 1:
    ;   rbx+rsi*4 = rbx+3*4 = 5
    ;   eax = 7 + 5 = 12
    add eax, dword [rbx+rsi*4]

    ; 0:
    ;   rsi = 1 + 2 = 3
    ; 1:
    ;   rsi = 3 + 2 = 5
    add rsi, 2

    ; will include 0 and 1 iterations
    loop MainLoop

    ; multiplication spec:
    ;   edx:eax = eax * dword [rbx]
    ; we have:
    ;   eax = 12
    ;   dword [rbx] = 2
    ; so:
    ;   edx:eax = 12 * 2 = 24, which fits to eax so:
    ;       edx = 0
    ;       eax = 24
    imul dword [rbx]

Last:
    mov rax, SYS_EXIT
    mov rdi, EXIT_SUCCESS
    syscall

; final answer after execution:
; eax = 24
; edx = 0
; rcx = 0
; rsi = 5
