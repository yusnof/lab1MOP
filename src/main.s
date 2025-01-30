.global main

main:
    @ loading
     ldr r0,=src
     ldr r1,=dst
     mov r2, #2
     mov r3, #6
     bl copyelements
     loop: b loop
     .org 0x30
     dst: .space 16
     src: .word 1,2,3,4,-1,-2,-3,-4

@copyelements
copyelements: 
    PUSH {R4-R6, LR}    @ Save registers
    MOV R4, R0          @ R4 = src_start
    MOV R5, R1          @ R5 = dst_start
    MOV R6, R2          @ R6 = size (number of elements)


@copyvec
copyvec:   PUSH {R4, R5} 
           MOV R3, #0  @move 0 to r3 
copyvec1:  CMP R3, R2
           BGE copyvec2
           LSL R5, R3, #1
           LDRSH R4,[R1, R5]
           LSL R5, R3,#2
           STR R4, [R0, R5] @dest[i] = R4
           ADD R3, R3, #1 @i++ we update the R3 with the new value 
           B copyvec1  @we go back to the loop
copyvec2:  POP {R4, R5} 
           BX LR 


    @ infinite loop to halt program execution
.end_loop: 
    B .end_loop
