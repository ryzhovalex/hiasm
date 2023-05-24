; movsx instruction exploration
; *******************************

section .data

SUCCESS equ 0
SYS_exit equ 60

var1 db 11
var2 db -15


section .text

global _start
_start:
    movsx rsi, byte [var1]
    movsx rsi, byte [var2]

last:
    mov rax, SYS_exit
    mov rdi, SUCCESS
    syscall


