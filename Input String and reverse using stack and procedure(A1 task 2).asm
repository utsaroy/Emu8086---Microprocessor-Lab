; ------------------------------------------------------------
; Read a string from keyboard and reverse it using the stack
; EMU8086 / DOS INT 21h
; ------------------------------------------------------------
org 100h

call inp_str             ; read characters into str[], sets len
call rev_str             ; reverse str[] in-place using stack

ret                      ; end of the program       
       
str db 50 dup(0)         ; buffer for input (up to 50 chars)
len dw ?                 ; actual length (set by inp_str)

; ----------------------------
; Read string until Enter (CR)
; ----------------------------
inp_str proc near
    pushf                ; preserve flags
    xor si, si           ; SI = 0, index into str
    
  inp_loop:
    mov ah, 01h          ; DOS: read char (echo), ASCII -> AL
    int 21h
    cmp al, 0dh          ; Enter (carriage return)?
    je inp_ses
    mov str[si], al      ; store char in buffer
    inc si               ; advance index
    jmp inp_loop         ; continue reading
    
  inp_ses: 
    mov len, si          ; save number of characters read
    popf
    ret
inp_str endp    

; ----------------------------------------------
; Reverse string in-place using CPU stack (LIFO)
; Push all bytes, then pop back in reverse order
; ----------------------------------------------
rev_str proc near
    pushf
    xor si, si           ; SI = 0
    
  push_suru:
    mov al, str[si]      ; get next byte
    push ax              ; push (AL) onto stack
    inc si
    cmp si, len          ; processed all bytes?
    jl push_suru         ; if not, continue pushing
    
    xor si, si           ; reset index to start
  pop_suru:
    pop ax               ; pop last pushed byte
    mov str[si], al      ; write back -> now reversed order
    inc si
    cmp si, len
    jl pop_suru
    
    ; At this point str[] holds the reversed string
    ; Note: No null terminator is written; printing needs length-aware routine
    
    popf
    ret
rev_str endp





