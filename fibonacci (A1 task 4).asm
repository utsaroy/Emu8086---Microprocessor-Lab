org 100h

xor cx, cx            ; CX = 0; LOOP decrements CX each iteration
xor si, si            ; SI = 0; index into arr
mov cl, num           ; CL = iteration count (low byte of CX)

mov arr[si], 0        ; arr[0] = 0 (F0)
mov arr[si+1], 1      ; arr[1] = 1 (F1)

l1:
    mov al, arr[si+1] ; AL = arr[i+1]
    add al, arr[si]   ; AL = arr[i+1] + arr[i] (next Fibonacci)
    mov arr[si+2], al ; store next value at arr[i+2]
    inc si            ; i++
loop l1               ; repeat until CX==0

ret

num db 5              ; number of iterations
arr db 32 dup(?)      ; buffer for results (ensure >= num+2 bytes)


