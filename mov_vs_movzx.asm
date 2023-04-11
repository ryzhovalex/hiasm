; mov and movzx comparison
; *******************************

section .data

SUCCESS equ 0
SYS_exit equ 60

var1 dw 150


section .text

global _start
_start:
    mov ax, word [var1]
    movzx eax, ax

last:
    mov rax, SYS_exit
    mov rdi, SUCCESS
    syscall


