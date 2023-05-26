; Sums all values in a list.

section .data

EXIT_SUCCESS equ 0
SYS_exit equ 60

lst dd 1002, 1004, 1006, 1008, 10010
len dd 5
sum dd 0


section .text

global _start

_start:
    ; set up rcx register so we can loop enough times loop decrements rcx until
    ; rcx = 0
    mov ecx, dword [len]
    mov rsi, 0  ; set index = 0

sum_loop:
    ; 4 is a scale value equal to 4 bytes which is a double-word size. So in
    ; this case we just retrieve lst[rsi]
    mov eax, dword [lst+(rsi*4)]

    ; sum + lst[rsi]
    add dword [sum], eax

    inc rsi
    loop sum_loop

last:
    mov rax, SYS_exit
    mov rdi, EXIT_SUCCESS
    syscall
