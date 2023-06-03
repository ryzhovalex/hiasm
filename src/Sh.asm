; Gives a control to Linux Shell.

section .data
EXIT_SUCCESS equ 0
SYS_EXIT equ 60
SYS_EXEC equ 59

NULL equ 0
targetProgramName db "/bin/sh", NULL

section .text
global _start
_start:
    mov rax, SYS_EXEC
    mov rdi, targetProgramName
    syscall

Last:
    mov rax, SYS_EXIT
    mov rdi, 0
    syscall
