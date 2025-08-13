include 'emu8086.inc'     

org 100h

xor si, si            ; SI = 0, index into both strings

suru:                         
    mov al, str1[si]     ; load current char from str1
    cmp al, str2[si]     ; compare with corresponding char from str2    
    jne mile_nai         ; if different, strings are not the same
    inc si               ; next index
    cmp si, len          ; reached end (si < len)?
    jl suru              ; if more characters, continue
    
    printn "strings are the same"   ; all characters matched
    ret                  
    
mile_nai:
    printn "strings are not same"
    ret

str1 db "hello world"        ; first string (no trailing null)
len equ ($-str1)              ; length of str1 in bytes
str2 db "hello world"        ; second string to compare
