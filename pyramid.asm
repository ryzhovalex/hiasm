; Calculates the geometric information for each square pyramid.
;
; Geometric information is: total surface area and volume of each pyramid. Once
; the values are computed, the minimum, maximum, sum and average for the total
; surface areas and volumes are calculated.
;
; Formulas:
;   area = 2 * a * s + a^2
;   volume = (a^2 * height) / 3

section .data

EXIT_SUCCESS equ 0
SYS_exit equ 60

; each value in provided data is for one pyramid. A - is a base square side,
; S - is a pyramid slant.

a_sides
    db 10, 14, 13, 37, 54
    db 31, 13, 20, 61, 36
    db 14, 53, 44, 19, 42
    db 27, 41, 53, 62, 10
    db 19, 18, 14, 10, 15
    db 15, 11, 22, 33, 70
    db 15, 23, 15, 63, 26
    db 24, 33, 10, 61, 15
    db 14, 34, 13, 71, 81
    db 38, 13, 29, 17, 93
s_sides
    dw 1233, 1114, 1773, 1131, 1675
    dw 1164, 1973, 1974, 1123, 1156
    dw 1344, 1752, 1973, 1142, 1456
    dw 1165, 1754, 1273, 1175, 1546
    dw 1153, 1673, 1453, 1567, 1535
    dw 1144, 1579, 1764, 1567, 1334
    dw 1456, 1563, 1564, 1753, 1165
    dw 1646, 1862, 1457, 1167, 1534
    dw 1867, 1864, 1757, 1755, 1453
    dw 1863, 1673, 1275, 1756, 1353
heights
    dd 14145, 11134, 15123, 15123, 14123
    dd 18454, 15454, 12156, 12164, 12542
    dd 18453, 18453, 11184, 15142, 12354
    dd 14564, 14134, 12156, 12344, 13142
    dd 11153, 18543, 17156, 12352, 15434
    dd 18455, 14134, 12123, 15324, 13453
    dd 11134, 14134, 15156, 15234, 17142
    dd 19567, 14134, 12134, 17546, 16123
    dd 11134, 14134, 14576, 15457, 17142
    dd 13153, 11153, 12184, 14142, 17134

length dd 50

area_min dd 0
area_max dd 0
area_sum dd 0
area_average dd 0

volume_min dd 0
volume_max dd 0
volume_sum dd 0
volume_average dd 0

; additional variables
dd_two dd 2
dd_three dd 3


section .bss
areas resd 50
volumes resd 50


section .text
global _start
_start:
    ; length counter
    mov ecx, dword [length]

    ; index
    mov rsi, 0

calculate_area:
    ; take sides: r8d=a, r9d=s
    movzx r8d, byte [a_sides+rsi]
    ; rsi*2 since we operate words here, so 8+8 bits
    movzx r9d, word [s_sides+rsi*2]

    mov eax, r8d

    ; a * 2 * s
    mul dword [dd_two]
    mul r9d

    ; use ebx to store 2 * a * s result, and calculate a^2 in new eax
    mov ebx, eax
    mov eax, r8d
    mul r8d

    ; then sum a^2 and 2 * a * s
    add eax, ebx

    mov dword [areas+rsi*4], eax

calculate_volume:
    ; a^2
    movzx eax, byte [a_sides+rsi]
    mul eax

    ; * h
    mul dword [heights+rsi*4]

    ; / 3
    div dword [dd_three]

    mov dword [volumes+rsi*4], eax

loop_initial_calculation:
    ; loop until all length is iterated (see ecx register initialization)
    inc rsi
    loop calculate_area

calculate_stats:
    ; initialize area stats
    mov eax, dword [areas]
    mov dword [area_min], eax
    mov dword [area_max], eax
    mov dword [area_sum], 0

    ; initialize volume stats
    mov eax, dword [volumes]
    mov dword [volume_min], eax
    mov dword [volume_max], eax
    mov dword [volume_sum], 0

    ; restart loop counter and index
    mov ecx, dword[length]
    mov rsi, 0

add_to_area_sum:
    mov eax, dword [areas+rsi*4]
    add dword [area_sum], eax

compare_min_area:
    ; check if it is a new minimal value
    cmp eax, dword [area_min]
    jae compare_max_area
    mov dword [area_min], eax

compare_max_area:
    cmp eax, dword [area_max]
    jbe add_to_volume_sum
    mov dword [area_max], eax

add_to_volume_sum:
    mov eax, dword [volumes+rsi*4]
    add dword [volume_sum], eax

compare_min_volume:
    cmp eax, dword [volume_min]
    jae compare_max_volume
    mov dword [volume_min], eax

compare_max_volume:
    cmp eax, dword [volume_max]
    jbe loop_stats
    mov dword [volume_max], eax

loop_stats:
    inc rsi
    loop add_to_area_sum

calculate_average_area:
    mov eax, dword [area_sum]
    mov edx, 0
    div dword [length]
    mov dword [area_average], eax

calculate_average_volume:
    mov eax, dword [volume_sum]
    mov edx, 0
    div dword [length]
    mov dword [volume_average], eax

last:
    mov rax, SYS_exit
    mov rdi, EXIT_SUCCESS
    syscall
