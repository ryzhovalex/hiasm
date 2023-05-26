; x86-64 Assembly Language Programming with Ubuntu - Jorgensen, Chapter 8,
; Quiz #6

section .data

EXIT_SUCCESS equ 0
SYS_EXIT equ 60

lst dd 8, 6, 4, 2, 1, 0

section .text

global _start

_start:
    mov rbx, lst
    mov rsi, 1
    mov rcx, 3
    ; edx = 8
    mov edx, dword [rbx]

MainLoop:
    ; rsi == 1 ? eax = 8; rsi == 2 ? eax = 6; and so on
    mov eax, dword [lst+rsi*4]
    inc rsi
    loop MainLoop
    ; signed multiplication for single double-word operand gives:
    ;   eax * dword [lst] = edx:eax
    ;
    ; and at this point we have:
    ;   dword [lst] = 8 (first element of the list)
    ;   eax = 2 (since we used lst+rsi*4, where rsi was equal to 3, afterwards,
    ;            the iteration was stopped, so lst+3*4 = 2)
    ;
    ; so after this multiplication:
    ;   edx:eax = 2 * 8 = 16, or since 16 is fit into eax size, eax = 16
    ;
    ; but note, that previously edx = 8 (after "mov edx, dword[rbx]"
    ; instruction), but now we've overwritten it to 0's, since as have been
    ; said, the 16 value fitted in eax, extending 0's to edx
    imul dword [lst]

Last:
    mov rax, SYS_EXIT
    mov rdi, EXIT_SUCCESS
    syscall

; final answer, after execution:
;   eax = 16 (author gives rax=10 somehow, don't know why, maybe typo)
;   edx = 0
;   rcx = 0 (loop decremented it from 3 to 0)
;   rsi = 4 (last value incremented before the loop stopped)
