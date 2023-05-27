; Calculates data for a list of numbers:
;   - sum
;   - maximum
;   - minimum
;   - average

section .data

EXIT_SUCCESS equ 0
SYS_exit equ 60

lst dd 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
len dd 10
sum dd 0
average dd 0
averageRemainder dd 0
min dd 0
max dd 0


section .text

global _start

_start:
    mov ecx, dword [len]
    mov rsi, 0

;; Sets the min value from eax register.
SetMin:
    mov dword [min], eax
    jmp CompareMax

;; Sets the max value from eax register.
SetMax:
    mov dword [max], eax
    jmp DoLoop

;; Starts a new iteration of loop.
StartLoop:
    jmp IncreaseSum

;; Adds the next value of the list to the sum.
IncreaseSum:
    mov eax, dword [lst+(rsi*4)]
    add dword [sum], eax

;; Compares eax to decide whether a new min value should be set.
CompareMin:
    cmp eax, [min]
    jb SetMin

;; Compares eax to decide whether a new max value should be set.
CompareMax:
    cmp eax, [max]
    ja SetMax

;; Continues the loop to the next iteration.
DoLoop:
    inc rsi
    loop StartLoop

;; Sets a final average value based on collected sum.
SetAverage:
    mov eax, dword [sum]
    mov edx, 0
    div dword [len]
    mov dword [average], eax
    mov dword [averageRemainder], edx

Last:
    mov rax, SYS_exit
    mov rdi, EXIT_SUCCESS
    syscall
