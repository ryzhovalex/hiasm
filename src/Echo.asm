; Sends typed messages back to the user.

section .data
LF equ 10
NULL equ 0

TRUE equ 1
FALSE equ 0

EXIT_SUCCESS equ 0

STDIN equ 0
STDOUT equ 1
STDERR equ 2

SYS_READ equ 0
SYS_WRITE equ 1
SYS_EXIT equ 60

STRLEN equ 50

prompt db "Type text: ", NULL
newline db LF, NULL

section .bss
char resb 1
; we wait 50 characters plus two additional for the LF and final NULL
inline resb STRLEN+2

section .text
global _start
_start:

DisplayPrompt:
    mov rdi, prompt
    call Print

; Reads characters from user, one at a time.
ReadInput:
    mov rbx, inline
    ; r12: char count
    mov r12, 0

ReadInputLoop:
    mov rax, SYS_READ
    mov rdi, STDIN
    lea rsi, byte [char]
    ; count=1, read one at a time
    mov rdx, 1
    syscall

    mov al, byte [char]
    ; done the input at linefeed
    cmp al, LF
    je ReadInputDone

    ; if chars.length >= STRLEN:
    ;   stop placing in buffer
    ;
    ; i.e. if user sends new characters but not linefeed, the loop will go over
    ; and over checking for LF without doing any insertions, which is desired
    ; behavior
    inc r12
    cmp r12, STRLEN
    jae ReadInputLoop

    ; since rbx = inline and al = char, then this operation is inline[i] = char
    mov byte [rbx], al
    ; go next index for `inline` byte-array
    inc rbx

    jmp ReadInputLoop

ReadInputDone:
    ; terminate `inline` string
    mov byte [rbx], NULL

; Echoes the input message back to the user.
Echo:
    mov rdi, inline
    call Print

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
