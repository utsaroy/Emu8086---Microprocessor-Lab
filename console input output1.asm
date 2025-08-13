new_line macro        ;macro declaration
    mov ah, 02        ;set ah=2 for output
    mov dl, 10        ;asci value for line break
    int 21h           ;call interrupt to print newline
endm                  ;end of macro



org 100h              ;program starts here
            
new_line              ;prints a newline
call out_num          ;call 

ret

num dw 12      

        

out_num proc near ;procedure declaration
    pushf
    mov ax, num  ;store the num to ax
    xor cx, cx   ;clear cx - here we will count the digits
    abar_jaa:
    mov bx, 0ah  ;set bx to 10
    xor dx, dx   ;clear dx before division
    div bx       ;divide ax by bx(10) (ax = ax/10)
    mov bx, ax   ;move result to bx
    mov ax, dx   ;store reminder to ax
    push ax      ;push ax to stack
    mov ax, bx   ;get back the result from bx
    inc cx
    cmp ax, 0
    jg abar_jaa
    
    out_l1:
    pop ax       
    mov dl, al
    add dl, '0'
    mov ah, 02h
    int 21h
    
    
    loop out_l1
    popf
    ret
out_num endp

inp_num proc near
    pushf        ;push flags
    inp_suru:
    mov ah, 01h  ;set ah = 1 for input
    int 21h      ;call interrupt
    cmp al, 0dh  ;compare input with /n
    je inp_ses   
    cmp al, ' '  ;compare input with space
    je inp_ses   ;jump to end if input is a space
    
    sub al, '0'  ;get the digit from asci value
    xor bx, bx   ;clear bx
    mov bl, al   
    mov ax, 0ah  ;set ax to 10
    mul num      ;multiply ax(10) by num (ax = 10*num)
    add ax, bx   ;add the input digit to the number
    mov num, ax  ;save value to num variable
    jmp inp_suru ;take another digit as input
    
    inp_ses:
    popf
    ret
inp_num endp




