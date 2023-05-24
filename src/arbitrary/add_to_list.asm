; x86-64 Assembly Language Programming with Ubuntu - Jorgensen, Chapter 8,
; Quiz #4
;
; What is the value of eax and edx registers after execution?

section .data

EXIT_SUCCESS equ 0
SYS_exit equ 60

lst dd 2, 3, 4, 5, 6, 7

section .text

global _start

_start:
    # now we can iterate through list, but using rbx register?
    mov rbx, lst
    # and now we retrieve the next 4 bytes of rbx, or of lst
    add rbx, 4
    # eax = 3 (taking second value since we moved 4 bytes)
    mov eax, dword [rbx]
    # edx = 2 (taking first value)
    mov edx, dword [lst]

last:
    mov rax, SYS_exit
    mov rdi, EXIT_SUCCESS
    syscall
