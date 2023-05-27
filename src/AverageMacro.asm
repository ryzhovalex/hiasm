;; Calculates the average.
;;
;; Args:
;;      1: list to calculate the average for
;;      2: length of the list
;;      3: where to place the result
%macro Average 3
    mov eax, 0
    mov ecx, dword [%2]
    mov r12, 0
    lea rbx, [%1]

%%SumLoop:
    add eax, dword [rbx+r12*4]
    inc r12
    loop %%SumLoop

    cdq
    idiv dword [%2]
    mov dword [%3], eax

%endmacro


section .data

EXIT_SUCCESS equ 0
SYS_EXIT equ 60

list1 dd 4, 5, 2, -3, 1
len1 dd 5
average1 dd 0

list2 dd 2, 6, 3, -2, 1, 8, 19
len2 dd 7
average2 dd 0


section .text
global _start
_start:
    Average list1, len1, average1
    Average list2, len2, average2

last:
    mov rax, SYS_EXIT
    mov rdi, EXIT_SUCCESS
    syscall
