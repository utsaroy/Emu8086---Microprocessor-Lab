include "emu8086.inc"

org 100h
    
    mov cx, len1        ; loop over all chars of str1
    xor si, si          ; SI = 0 (index in string)
    xor ax, ax          ; clear AX so AH=0 when moving AL->AX
  l1:
        mov al, str1[si] ; AL = current char from str1
        sub al, 'a'      ; map 'a'..'z' -> 0..25 (assumes lowercase)
        mov di, ax       ; DI = index into frequency array
        inc arr1[di]     ; increment frequency for this letter
        inc si           ; next char
    loop l1 
    
    mov cx, len2        ; do the same for str2
    xor si, si
    xor ax, ax
  l2:
        mov al, str2[si]
        sub al, 'a'
        mov di, ax
        inc arr2[di]
        inc si
    loop l2
    
    mov cx, 26          ; compare all 26 letter counts
    xor si, si
  l3:              
        mov al, arr1[si] ; AL = count in arr1
        cmp al, arr2[si] ; compare with count in arr2
        jne not_anagram  ; mismatch -> not an anagram
        inc si           ; advance to next letter bucket
    loop l3             
    
    printn "anagram"
    ret
    
not_anagram:
    printn "not anagram"

ret

str1 db "hello"
len1 equ ($-str1)    ; length of str1 in bytes

str2 db "ehllo" 
len2 equ ($-str2)    ; length of str2 in bytes

arr1 db 26 dup(0)    ; frequency table for str1
arr2 db 26 dup(0)    ; frequency table for str2



