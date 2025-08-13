# Microprocessor Lab Tasks (EMU8086)

![EMU8086](https://img.shields.io/badge/EMU8086-Assembly-blue?style=for-the-badge)
![Status](https://img.shields.io/badge/repo-lab_tasks-success?style=for-the-badge)
![Beginner Friendly](https://img.shields.io/badge/level-beginner--friendly-brightgreen?style=for-the-badge)

This repository contains the lab tasks from my Microprocessor lab. Each task is implemented in 8086 assembly (EMU8086) and shared to help others learn. Please use this for understanding and practice.

Important: Follow your institution’s academic integrity rules. Learn from the code, don’t submit it verbatim if that violates your policy.

## Table of Contents
- Overview
- Setup
- How to Run
- Lab Task Lists
- Tasks Included
- Tutorials and Resources
- Basic Examples
- Notes and Tips
- Contributing

## Overview
- Architecture: Intel 8086 (real-mode, COM-style programs)
- Tools: EMU8086 IDE and DOS interrupts (INT 21h, INT 10h)
- Goal: Provide clear, commented solutions to common lab problems

## Setup
1. Install EMU8086 from http://www.emu8086.com/
2. Open any `.asm` file from this repository in EMU8086.
3. Some programs use `printn` from `emu8086.inc`. If needed, place that include file in EMU8086’s include path or the same folder.

## How to Run
1. Open a task file (for example, `perfect number (A1 task 3).asm`).
2. Press F9 (Compile and Emulate) in EMU8086.
3. Press F5 (Run). Read the on-screen output.

## Lab Task Lists

### A1 Lab Tasks
1. Occurrence equality for two same-length strings (frequency compare) – TODO
2. Take string from console, reverse using stack and procedure, store back (no extra buffers) – Implemented → `Input String and reverse using stack and procedure(A1 task 2).asm`
3. Check perfect number – Implemented → `perfect number (A1 task 3).asm`
4. Fibonacci sequence generator – Implemented → `fibonacci (A1 task 4).asm`
5. Check if two strings are anagram – Implemented → `anagram (A1 task 5).asm`

### A2 Lab Tasks
1. Armstrong number, any digit (up to 4 digits) – TODO
2. Palindrome detector (numeric, any digit range) – TODO
3. Find all palindrome numbers in a given range – TODO
4. Remove duplicates from an array (use stack, procedure, parameter passing) – TODO
5. (reserved) – TODO

### B1 Lab Tasks
1. Check a number even or odd; if even set DX=0001h else DX=0002h – TODO
2. Count frequency of digits 0–9 from an array a containing numbers 1–10; output counts in array b – TODO
3. Compute 1 + r^2 + r^3 + ... + r^n using procedure; pass (r, n) via stack – TODO
4. String palindrome (ignore punctuation/spaces), console I/O, no extra variable/constant for length – TODO
5. Armstrong number, any digit (up to 4 digits) – TODO
6. Histogram: input {2,4,5,2,5,4,1}, output array size 10 (init 0); increment index for each value – TODO
7. String palindrome – TODO
8. Run-length frequency count: input aaaaaabbccc → output a6b2c3 (console I/O + procedure) – TODO

### B2 Lab Tasks
1. Compare two numbers: DX=0001h if first>second, DX=0002h if first<second, DX=0003h if equal – TODO
2. Given array size 7, create array size 2 containing counts of even and odd numbers – TODO
3. Two strings: count how many substrings of first match the second; store first occurrence index – TODO
4. Array: find second maximum and second minimum – TODO
5. Frequency count with appended counts (console I/O + procedure, any param passing) – TODO
6. BCD to BIN – TODO
7. Prime sum – TODO
8. Bubble sort – TODO

> PRs welcome to implement the TODO items. Follow the file naming pattern and include brief comments at the top.

## Tasks Included
- Console I/O number demo
  - File: `console input output.asm`
  - Reads digits from keyboard, builds a number, prints it back in decimal using INT 21h.

- A1 Task 1: Compare two strings for equality
  - File: `check if two strings are same or not (A1 task 1).asm`
  - Compares two strings byte-by-byte and prints whether they match.

- A1 Task 2: Input string and reverse using stack and procedure
  - File: `Input String and reverse using stack and procedure(A1 task 2).asm`
  - Reads a line into a buffer, reverses it using stack operations.

- A1 Task 3: Perfect number checker
  - File: `perfect number (A1 task 3).asm`
  - Sums proper divisors (1..n-1) and checks if the sum equals the number.

- A1 Task 4: Fibonacci sequence generator
  - File: `fibonacci (A1 task 4).asm`
  - Generates Fibonacci numbers into an array (8-bit, wraps at 255).

- A1 Task 5: Anagram checker using frequency counts
  - File: `anagram (A1 task 5).asm`
  - Builds letter frequency tables for two strings and compares them.

## Tutorials and Resources

- EMU8086
  - Official site: http://www.emu8086.com/
  - Quick start (video): https://www.youtube.com/playlist?list=PLmxT2pVYo5LB5EzTPZGfFN0c2GDiSXgQe
- Instruction Set References
  - 8086 Instruction Set (mlsite): http://www.mlsite.net/8086/
  - Sandpile x86 (reference): https://sandpile.org/
- Books
  - Assembly Language Programming (Ytha Yu)
  - Professional Assembly Language (Richard Blum)
- Practice/Simulators
  - 8086 Online Emulator: https://schweigi.github.io/assembler-simulator/
  - CPULator 8086: https://cpulator.01xz.net/?sys=8086

## Basic Examples

These are tiny, focused examples you can paste into a COM program (org 100h). They show the 8086 instruction behavior concisely.

### Add (ADD)
```assembly
; Adds BX to AX
mov ax, 5
mov bx, 3
add ax, bx     ; AX = 8
```

### Multiply (MUL)
```assembly
; 8-bit: AL * r/m8 -> AX
mov al, 5
mov bl, 3
mul bl         ; AX = 15 (AH:AL = 00:0Fh)

; 16-bit: AX * r/m16 -> DX:AX
mov ax, 1234h
mov bx, 2
mul bx         ; DX:AX = 0000:2468h
```

Notes:
- MUL is unsigned. For signed multiplication, use IMUL (not on plain 8086 in 8/16-bit forms beyond basic).

### Divide (DIV)
```assembly
; 8-bit: (AX) / r/m8 -> AL=quotient, AH=remainder
mov ax, 0012h  ; AH:AL = 00:12 (decimal 18)
mov bl, 5
div bl         ; AL = 3, AH = 3

; 16-bit: (DX:AX) / r/m16 -> AX=quotient, DX=remainder
mov ax, 1234h
xor dx, dx     ; must clear DX for 16-bit unsigned division
mov bx, 10
div bx         ; AX = 0x01ED (493), DX = 0x0004 (remainder 4)
```

Notes:
- Before DIV r/m16, set DX to 0 if the dividend fits in 16 bits (prevents divide error).
- DIV is unsigned; IDIV is signed.

### Push/Pop (stack)
```assembly
; Save/restore registers on the stack
push ax
push bx
; ... work with AX, BX ...
pop  bx        ; restore in reverse order
pop  ax
```

### Procedure (proc/ret) syntax
```assembly
org 100h
call demo_proc    ; call procedure
ret               ; return to DOS

; ----
demo_proc proc near
    push ax           ; save used regs (convention)
    mov  ax, 1234h
    ; ... do work ...
    pop  ax
    ret               ; return to caller
demo_proc endp
```

Notes:
- Use push/pop inside procedures to preserve caller registers as needed.

### Macro syntax
```assembly
; Define and use a macro
newline macro
    mov ah, 02h
    mov dl, 13       ; CR
    int 21h
    mov dl, 10       ; LF
    int 21h
endm

org 100h
newline             ; expands inline
ret
```

Notes:
- Macros expand at assemble-time; they are not runtime calls like procedures.

## Notes and Tips
- Many programs use DOS services via INT 21h for character I/O.
- Where used, `printn` comes from `emu8086.inc` (EMU8086 macro library).
- Buffer sizes are chosen for simple demos. Adjust sizes as needed.
- Some examples assume lowercase letters and ASCII input.
- COM programs start at `org 100h` and typically end with `ret` to return to DOS.

## Contributing
- Open issues or pull requests to add new lab tasks or improvements.
- Keep code clear and commented.
- If adding tasks, follow the existing file naming pattern and include a short description at the top of the file.

---

Happy learning and good luck with your Microprocessor lab! 🚀
