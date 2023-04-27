; Calculates the geometric information for each square pyramid.
;
; Geometric information is: total surface area and volume of each pyramid. Once
; the values are computes, the minimum, maximum, sum and average for the total
; surface areas and volumes are calculated.

section .data

EXIT_SUCCESS equ 0
SYS_exit equ 60

; each value in provided data is for one pyramid. A - is a base square side,
; B - is a pyramid side.

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
b_sides
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
total_areas resd 50
total_volumes resd 50


section .text
global _start
_start:
    mov ecx, dword [length]
