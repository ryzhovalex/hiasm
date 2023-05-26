; Find the n-th Fibonacci number.
; *******************************
section .data

SUCCESS equ 0
SYS_exit equ 60

; target index
n db 9

; current number index
i db 0

; the value under the current number index
result dw 0

; smallest preceding number
pre1 dw 0
; highest preceding number
pre2 dw 1


section .text

global _start
_start:

mov word [pre1], 0
mov word [pre2], 1

cmp byte [n], 0
je last

inc word [i]
mov word [result], 1
cmp byte [n], 1
je last

fibonacci:
    inc word [i]

    ; result = pre1 + pre2
    mov ax, word [pre1]
    add ax, word [pre2]
    mov word [result], ax

    mov bl, byte [i]
    cmp bl, byte [n]
    je last

continue:
    jmp move_pre_numbers

move_pre_numbers:
    ; pre1 = pre2
    mov ax, word [pre2]
    mov word [pre1], ax

    ; pre2 = result
    mov ax, word [result]
    mov word [pre2], ax

    jmp fibonacci

last:
    mov rax, SYS_exit
    mov rdi, SUCCESS
    syscall


