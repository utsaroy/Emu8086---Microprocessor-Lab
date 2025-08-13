; ------------------------------------------------------------
; - Reads a decimal number from keyboard
; - Prints it back to the screen
; ------------------------------------------------------------

;macro to print newline in console
new_line macro
    mov ah, 02          ; for output set ah=2
    mov dl, 10          ; ASCII LF (line feed). For CRLF, print 13 then 10.
    int 21h
endm  

org 100h                ; program starts here

call inp_num            ; read number into variable 'num'
new_line                ; print a newline for spacing
call out_num            ; output number from 'num' in decimal

ret                     ; return to DOS

; ---- data ----
num dw ?                ; 16-bit number (uninitialized; set in inp_num)

        

; ====================================================================
; PROCEDURE: out_num
; Purpose: Display a decimal number stored in 'num' variable
; Method: Extract digits by repeated division by 10, push to stack,
;         then pop and display each digit
; ====================================================================
out_num proc near   ;procedure declaration
    pushf               ; preserve flags
    mov ax, num         ; load number to AX (working register)
    xor cx, cx          ; CX will count digits pushed to the stack

    ; Extract digits from least-significant to most-significant
    abar_jaa:           ; digit-extraction loop
    mov bx, 0ah         ; base 10
    xor dx, dx          ; required before unsigned DIV (DX:AX / BX)
    div bx              ; AX := AX/10 (quotient), DX := AX%10 (remainder)
    mov bx, ax          ; save quotient in BX
    mov ax, dx          ; AX now holds remainder (0..9) = one decimal digit
    push ax             ; push digit so we can print in correct order later
    mov ax, bx          ; restore quotient to AX for next iteration
    inc cx              ; count this digit
    cmp ax, 0           ; are we done? (no more higher digits)
    jg abar_jaa         ; if quotient > 0, keep extracting

    ; Print digits in correct order by popping from stack
    out_l1:
    pop ax              ; get last pushed digit
    mov dl, al          ; DL = digit (0..9)
    add dl, '0'         ; convert to ASCII character
    mov ah, 02h         ; DOS: display character
    int 21h

    loop out_l1         ; repeat until CX == 0
    popf
    ret
out_num endp

; ====================================================================
; PROCEDURE: inp_num
; Purpose: Read a decimal number from keyboard and store in 'num'
; Method: Read keystrokes, stop at Enter/Space, accumulate: num=num*10+digit
; Notes: Expects digits '0'..'9'. INT 21h/AH=01 echoes the key.
; ====================================================================
inp_num proc near
    pushf               ; preserve flags
    mov num, 0          ; start with 0 so accumulation is correct

    inp_suru:           ; input loop
    mov ah, 01h         ; DOS: read character (echoed), ASCII in AL
    int 21h

    ; End on Enter (CR=0Dh) or Space (20h)
    cmp al, 0dh         ; Enter (carriage return)
    je  inp_ses
    cmp al, ' '         ; Space
    je  inp_ses

    ; Convert ASCII digit to numeric (assumes '0'..'9') and accumulate
    sub al, '0'         ; AL = digit value 0..9
    xor bx, bx
    mov bl, al          ; BL = digit

    mov ax, 0ah         ; AX = 10
    mul num             ; DX:AX = AX * num => AX = 10 * num (fits in AX if num<=6553)
    add ax, bx          ; AX = 10*num + digit
    mov num, ax         ; store back

    jmp inp_suru        ; read next character

    inp_ses:
    popf
    ret
inp_num endp
