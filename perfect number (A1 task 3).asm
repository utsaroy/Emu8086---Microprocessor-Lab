; ------------------------------------------------------------
; Perfect number checker (8086/EMU8086)
; A number is perfect if the sum of its proper divisors equals the number.
; This program sums all divisors of 'num' from 1 to num-1 and compares.
; Uses: CX = current divisor, BX = running sum, AX/DX for division
; Requires: emu8086.inc for printn macro
; ------------------------------------------------------------
include "emu8086.inc"
org 100h
  
    mov cx, 1          ; CX = divisor candidate, start at 1 (avoid div by 0)
    xor bx, bx         ; BX = sum of proper divisors (accumulator)
  suru:
    mov ax, num        ; AX = dividend (number being tested)
    xor dx, dx         ; DX must be 0 before 16-bit unsigned DIV
    div cx             ; (DX:AX)/CX -> AX = quotient, DX = remainder
    
    cmp dx, 0h         ; remainder == 0 ? CX divides num
    jne not_divisor    ; if not divisible, skip adding
    
    add bx, cx         ; sum += CX (proper divisor)
  
  not_divisor:
    inc cx             ; test next candidate
    cmp cx, num        ; only check proper divisors (< num)
    jl suru            ; continue loop while CX < num
    
    cmp bx, num        ; is sum of proper divisors equal to the number?
    je perfect         ; yes -> perfect number
    
    printn "its not a perfect num" ; no -> not perfect
    ret
    
  perfect:
    printn "its a perfect number"

ret

num dw 12              ; test value (try 6, 28 for perfect numbers)




