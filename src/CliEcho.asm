; Reads and displays the CLI parameters passed.

section .data
NULL equ 0
LF equ 10
NEWLINE db LF, NULL

SYS_EXIT equ 60
SYS_WRITE equ 1
EXIT_SUCCESS equ 0
STDOUT equ 1

section .text
global main
main:
    ; rdi - argument count
    mov r12, rdi

    ; rsi - starting addres of argument vector
    mov r13, rsi

; Loops each argument to display to the screen.
;
; Each argument is a NULL terminated string.
SetupPrint:
    mov rdi, NEWLINE
    call Print

    mov rbx, 0

LoopPrint:
    mov rdi, qword [r13+rbx*8]
    call Print

    mov rdi, NEWLINE
    call Print

    inc rbx
    cmp rbx, r12
    jl LoopPrint

Last:
    mov rax, SYS_EXIT
    mov rdi, EXIT_SUCCESS
    syscall

global Print
Print:
    push rbx

CountChars:
    mov rbx, rdi
    mov rdx, 0

CountCharsLoop:
    cmp byte [rbx], NULL
    je CountCharsDone

    inc rdx
    inc rbx

    jmp CountCharsLoop

CountCharsDone:
    ; skip printing if no chars passed
    cmp rdx, 0
    je PrintDone

    mov rax, SYS_WRITE
    mov rsi, rdi
    mov rdi, STDOUT
    ; ...and rdx has been already set above as a count to write
    syscall

PrintDone:
    pop rbx
    ret
