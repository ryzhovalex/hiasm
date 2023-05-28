; Calculates data for a list of numbers, but in form of function:
;   - sum
;   - maximum
;   - minimum
;   - average
;   - medians

section .data

EXIT_SUCCESS equ 0
SYS_exit equ 60

arr dd 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
len dd 10

sum dd 0
min dd 0
max dd 0
median1 dd 0
median2 dd 0
average dd 0


section .text

; Calculates statistics for an array of numbers.
;
; The array should be sorted in ascending order.
;
; For the odd length of the arr, the median1 = median2, for the even length,
; they represent different values.
;
; Args:
;   arr, address, rdi
;   len, dword value, esi
;   min, address, rdx
;   median1, address, rcx
;   median2, address, r8
;   max, address, r9
;   sum, address, stack (rbp+16)
;   average, address, stack (rbp+24)
global Stats
Stats:
    ; setup call frame
    push rbp
    mov rbp, rsp

    ; preserve saved register
    push r12

GetMin:
    ; get minimal value, since the array is sorted by convention, we can get
    ; the first one
    mov eax, dword [rdi]
    mov dword [rdx], eax

GetMax:
    ; get maximum value, we need to set len-1 since we want to address the last
    ; element of the array
    mov r12, rsi
    dec r12
    mov eax, dword [rdi+r12*4]
    mov dword [r9], eax

GetMedians:
    ; rax = len
    mov rax, rsi
    mov rdx, 0
    mov r12, 2
    ; rax = len / 2
    div r12

    cmp rdx, 0
    je GetMediansEven

GetMediansOdd:
    ; r12d = arr[len/2]
    mov r12d, dword [rdi+rax*4]

    ; median1 = median2
    mov dword [rcx], r12d
    mov dword [r8], r12d

    jmp GetSum

GetMediansEven:
    ; median2 = arr[len/2]
    mov r12d, dword [rdi+rax*4]
    mov dword [r8], r12d

    ; median1 = arr[len/2-1]
    dec rax
    mov r12d, dword [rdi+rax*4]
    mov dword [rcx], r12d

GetSum:
    mov r12, 0
    mov rax, 0

SumLoop:
    ; sum += arr[i]
    add eax, dword [rdi+r12*4]

    inc r12
    cmp r12, rsi
    jl SumLoop

    ; get sum address and return sum
    ; this should be done in two separate instructions in order to not
    ; overwrite the initial address on rbp+16 with instruciton like:
    ;   - mov dword [rbp+16], eax
    ; so we use intermediate register r12
    mov r12, qword [rbp+16]
    mov dword [r12], eax

GetAverage:
    cdq

    ; average = sum / len
    idiv rsi

    ; get target address for passing the result to
    mov r12, qword [rbp+24]
    ; return average, see why we do this in two commands above in SumLoop
    mov dword [r12], eax

Teardown:
    pop r12
    pop rbp
    ret

global _start
_start:
    push average
    push sum
    mov r9, max
    mov r8, median2
    mov rcx, median1
    mov rdx, min
    mov esi, dword [len]
    mov rdi, arr
    call Stats

    ; clear call frame
    add rsp, 16

Last:
    mov rax, SYS_exit
    mov rdi, EXIT_SUCCESS
    syscall
