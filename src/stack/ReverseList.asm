;; Reverse a list of numbers by pushing each number on stack and popping
;; it back.

section .data

EXIT_SUCCESS equ 0
SYS_EXIT equ 60

lst dq 1, 2, 3, 4, 5
len dq 5


section .text
global _start
_start:
    mov rcx, qword [len]
    mov rbx, lst
    mov r12, 0
    mov rax, 0

PushLoop:
    push qword [rbx+r12*8]
    inc r12
    loop PushLoop

Reset:
    mov rcx, qword [len]
    mov rbx, lst
    mov r12, 0

PopLoop:
    pop rax
    ; Note that we operating rbx here, but actually changing a lst, since we
    ; moved it's data. To me it's counterintuitive for now, but maybe we are
    ; somehow linking rbx and lst by `mov rbx, lst` operation.
    mov qword [rbx+r12*8], rax
    inc r12
    loop PopLoop

Last:
    mov rax, SYS_EXIT
    mov rdi, EXIT_SUCCESS
    syscall
