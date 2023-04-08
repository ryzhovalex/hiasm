; Play with "mov" instruction.
; ***

section .data
EXIT_SUCCESS equ 0 ; successful operation
SYS_exit equ 60 ; call code for terminate

d_value dd 0

b_num db 42
w_num dw 5000
d_num dd 73000
q_num dq 73000000

b_ans db 0
w_ans dw 0
d_ans dd 0
q_ans dq 0


section .text
global _start
_start:

; d_value = 27
mov dword [d_value], 27

; b_ans = b_num
mov al, byte [b_num]
mov byte [b_ans], al

; w_ans = w_num
mov ax, word [w_num]
mov word [w_ans], ax

; d_ans = d_num
mov eax, dword [d_num]
mov dword [d_ans], eax

; q_ans = q_num
mov rax, qword [q_num]
mov qword [q_ans], rax


; done, terminate program
last:
mov rax, SYS_exit
mov rdi, EXIT_SUCCESS
syscall
