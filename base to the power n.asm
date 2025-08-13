include "emu8086.inc"

org 100h
    
    mov base, 2
    mov exp, 3
    call power

ret 
base dw ?
exp dw ?
res dw ?

power proc near
    pushf 
    
    mov bx, base
    mov cx, exp
    mov ax, 1
    l1:
        mul bx     
    loop l1
    
    mov res, ax 
    
    popf
    ret
power endp
