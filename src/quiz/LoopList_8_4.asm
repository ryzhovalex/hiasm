; x86-64 Assembly Language Programming with Ubuntu - Jorgensen, Chapter 8,
; Quiz #4
;
; What is the value of eax and edx registers after execution?

section .data

EXIT_SUCCESS equ 0
SYS_exit equ 60

lst dd 8, 6, 4, 2, 1, 0

section .text

global _start

_start:
    mov rbx, lst
    mov rsi, 1
    mov rcx, 3
    mov edx, dword [rbx]

MainLoop:
    mov eax, dword [list+rsi*4]
    inc rsi
    loop MainLoop
    imul dword [list]

Last:
    mov rax, SYS_exit
    mov rdi, EXIT_SUCCESS
    syscall
