; Opens/creates a file, writes some information and closes the file.

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
SYS_CREATE equ 85
SYS_CLOSE equ 3

READ_OWNER_PERMISSION equ 00400q
WRITE_OWNER_PERMISSION equ 00200q

newLine db LF, NULL

filename db "hello.txt", NULL
fileBodyText db "I love pizza!"
             db LF, NULL
fileDescriptor dq 0

len dq $-fileBodyText-1

welcomeInfoMessage db "write to file"
                   db LF, LF, NULL
writeDoneInfoMessage db "write done", LF, NULL
openErrorMessage db "error opening file", LF, NULL
writeErrorMessage db "error writing to file", LF, NULL

section .text
global _start
_start:

PrintWelcomeMessage:
    mov rdi, welcomeInfoMessage
    call Print

OpenFile:
    mov rax, SYS_CREATE
    mov rdi, filename
    ; allow read/write, but how does it work?
    mov rsi, READ_OWNER_PERMISSION | WRITE_OWNER_PERMISSION
    syscall

    ; check result code
    cmp rax, 0
    jl ThrowOpenError

    ; otherwise save the descriptor
    mov qword [fileDescriptor], rax

WriteToFile:
    mov rax, SYS_WRITE
    mov rdi, qword [fileDescriptor]
    mov rsi, fileBodyText
    mov rdx, qword [len]
    syscall

    cmp rax, 0
    jl ThrowWriteError

    mov rdi, writeDoneInfoMessage
    call Print

CloseFile:
    mov rax, SYS_CLOSE
    mov rdi, qword [fileDescriptor]
    syscall

    jmp Last

ThrowOpenError:
    mov rdi, openErrorMessage
    call Print

    jmp Last

ThrowWriteError:
    mov rdi, writeErrorMessage
    call Print

    jmp Last

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
