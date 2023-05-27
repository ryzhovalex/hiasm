; Calculates data for a list of numbers:
;   - sum
;   - maximum
;   - minimum
;   - average
;   - middle value

section .data

EXIT_SUCCESS equ 0
SYS_exit equ 60

lst dd 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
len dd 10
; lst dd 0, 1, 2, 3, 4, 5, 6
; len dd 7

sum dd 0
min dd 0
max dd 0
average dd 0
averageRemainder dd 0
middle dd 0
middleRemainder dd 0


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

;; Sets a middle value based on an input list.
;;
;; For an odd number of items, the middle value is defined as the plain middle
;; value in the list. For an even number of values, it is the integer average
;; of the two middle values.
SetMiddle:

CheckLenEven:
    mov edx, 0
    mov eax, dword [len]
    mov ecx, 2
    div ecx
    cmp edx, 0
    ja SetMiddleOdd
    je SetMiddleEven

SetMiddleEven:
    mov edx, 0
    ; FIXME(ryzhovalex): if i knew how to manage exceptions in assembly, i
    ;   would use it here to terminate program on uneven number operated
    mov eax, dword [len]
    mov ecx, 2
    div ecx
    mov ebx, eax

    ; get first middle element
    mov eax, dword [lst+ebx*4]

    ; then add second middle element
    inc ebx
    add eax, dword [lst+ebx*4]

    ; and divide bro! to get arithmetic mean of course
    mov edx, 0
    mov ecx, 2
    div ecx
    mov dword [middle], eax
    mov dword [middleRemainder], edx

    jmp Last

SetMiddleOdd:
    mov edx, 0
    mov eax, dword [len]
    mov ecx, 2
    div ecx

    ; FIXME(ryzhovalex): edx should have remainder > 0, or an exception should
    ;   be thrown

    mov ecx, dword [lst+eax*4]
    mov dword [middle], ecx

    ; middleRemainder will always be set to 0 in odd len case
    mov dword [middleRemainder], 0

Last:
    mov rax, SYS_exit
    mov rdi, EXIT_SUCCESS
    syscall
