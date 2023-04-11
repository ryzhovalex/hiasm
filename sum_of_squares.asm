; Compute sum of squares from 1 to n (inclusive).
; **********************************************

section .data

SUCCESS equ 0
SYS_exit equ 60

n dd 10
result dq 0


section .text

global _start
_start:
    mov rbx, 1

    ; note that we operate with according sizes: so we push dword n to ecx, not
    ; to rax, since rax is for qword
    mov ecx, dword [n]

sum_loop:
    mov rax, rbx
    ; square the rax's value
    mul rax
    add qword [result], rax
    inc rbx
    loop sum_loop

last:
    mov rax, SYS_exit
    mov rdi, SUCCESS
    syscall
