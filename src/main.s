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
    MOV R2, R3  @ calculate the size as end - start
    MOV R3, #2
    
    BL copyvec              
             
    BX LR               

@copyvec
copyvec:   PUSH {R4, R5} 
         //  MOV R3, #0  @ move 0 to r3 
copyvec1:  CMP R3, R2
           BGE copyvec2
           LSL R5, R3, #2
           LDR R4, [R0, R5]
           LSL R5, R3, #1
           STRH R4, [R1, R5] @ dest[i] = R4
           ADD R3, R3, #1 @ i++ we update the R3 with the new value 
           B copyvec1  @ we go back to the loop
copyvec2:  POP {R4, R5} 
           BX LR 

    @ infinite loop to halt program execution
.end_loop: 
    B .end_loop