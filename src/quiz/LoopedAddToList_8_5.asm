; x86-64 Assembly Language Programming with Ubuntu - Jorgensen, Chapter 8,
; Quiz #5

section .data

EXIT_SUCCESS equ 0
SYS_EXIT equ 60

lst dd 2, 3, 5, 7, 9

section .text

global _start

_start:
    mov rsi, 4
    mov eax, 1
    mov rcx, 2

MainLoop:
    ; i=0:
    ;   rsi=4
    ;   dword [lst+rsi] = dword [lst+4] = 3
    ;   eax = 1 + 3 = 4
    ; i=1:
    ;   rsi=8
    ;   dword [lst+rsi] = dword [lst+8] = 5
    ;   eax = 4 + 5 = 9
    add eax, dword [lst+rsi]

    ; i=0:
    ;   rsi = 8
    ; i=1:
    ;   rsi = 12
    add rsi, 4

    ; i=0:
    ;   rcx - 1 = 1, continue
    ; i=1:
    ;   rcx - 1 = 0, break
    loop MainLoop

    ; dword [lst] = 2
    ; ebx = 2
    mov ebx, dword [lst]

Last:
    mov rax, SYS_EXIT
    mov rdi, EXIT_SUCCESS
    syscall

; final answer after execution:
; eax = 9
; ebx = 2
; rcx = 0
; rsi = 12
