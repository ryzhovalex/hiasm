; x86-64 Assembly Language Programming with Ubuntu - Jorgensen, Chapter 8,
; Quiz #7

section .data

EXIT_SUCCESS equ 0
SYS_EXIT equ 60

lst dd 8, 7, 6, 5, 4, 3, 2, 1, 0

section .text

global _start

_start:
    ; rbx = 8
    mov rbx, lst
    mov rsi, 0
    mov rcx, 3
    ; edx = 8
    mov edx, dword [rbx]

MainLoop:
    ; 0:
    ;   dword [lst+rsi*4] = dword [lst+0] = 8
    ;   eax = 0 + 8 = 8
    ; 1:
    ;   dword [lst+rsi*4] = dword [lst+1*4] = 7
    ;   eax = 8 + 7 = 15
    ; 2:
    ;   eax = 15 + 6 = 21
    add eax, dword[lst+rsi*4]
    ; 0:
    ;   rsi = 1
    ; 1:
    ;   rsi = 2
    ; 2:
    ;   rsi = 3
    inc rsi
    ; 0:
    ;   rcx = 2, continue
    ; 1:
    ;   rcx = 1, continue
    ; 2:
    ;   rcx = 0, break
    loop MainLoop

    ; cdq - convert double-word in eax into quadword in edx:eax
    cdq

    ; idiv - signed divide A/D - edx:eax for double word, eax = eax / <src>,
    ; the remainder is stored in edx
    ;
    ; eax = 21 / 8 = 2 rem 5, so
    ;   eax = 2
    ;   edx = 5
    idiv dword [lst]

Last:
    mov rax, SYS_EXIT
    mov rdi, EXIT_SUCCESS
    syscall

; final answer after execution:
; eax = 2
; edx = 5
; rcx = 0
; rsi = 3
