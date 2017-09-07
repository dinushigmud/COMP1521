# prog.s ... Game of Life on a NxN grid
#
# Needs to be combined with board.s
# The value of N and the board data
# structures come from board.s
#
# Written by Dinushi Galagama_Mudalige, August 2017


   .data
main_ret_save: .space 4

promptMessage: .asciiz "#Iterations: "
resultMessage_1: .asciiz  "\n===After iteration "
resultMessage_2: .asciiz  " ===\n"
maxiters:      .word   0
nn_neighbours: .word   0
char_period:   .asciiz "."
char_hash:     .asciiz "#"
char_newline:  .asciiz "\n"

### when accessign board[i][j]
### an offset of (i*N)+j is required

   .text
   .globl main
main:
   sw   $ra, main_ret_save

    #printf("# Iterations")
    li $v0, 4
    la $a0, promptMessage
    syscall

    #scanf - store value in maxiters
    li $v0, 5
    syscall

    sw $v0, maxiters

    
    #li $v0, 4
    #la $a0, textMessage
    #syscall

    #li $v0, 1
    #lw $a0, maxiters
    #syscall

    #for loops
    #first for loop
    lw $t0, maxiters #t0 is our max_constant
    li $t1, 1 #t1 is our counter n
    lw $t2, N #N - Game of life grid is 10*10
    li $t3, 0 #t3 is our counter i
    li $t4, 0 #t4 is our counter j
    n_loop:
        beq $t1, $t0, n_loop_end #if t1 == t0 then end n_loop
 
        
        #second for loop
        li $t3, 0
        i_loop:
            beq $t3, $t2, i_loop_end

                #third for loop
                li $t4, 0 #j =0 
                j_loop:
                    beq $t4, $t2, j_loop_end

                    #use a1: a2 to pass i:j as arguments
                    move $a1, $t3
                    move $a2, $t4
                    jal neighbours
                    #v1 = return value of int now

                    #if else statement
                    mul $t5, $t2, $t3
                    add $t5, $t5, $t4
                    lb $t6, board($t5)
                    lb $s7, newBoard($t5)


                    li $t7, 1
                    beq $t7, $t6, board_1 #if board[i][j] == 1
                    li $t7, 3
                    beq $t7, $v1, nn_3  #if nn == 3

                    #if board[i][j] != 1 && nn != 3
                    li $s7, 0
                    sb $s7, newBoard($t5)
                    beq $t6, $zero, if_end

                    board_1:
                        li $t7, 2
                        blt $v1, $t7, nn_lt2 #if(nn < 2)
                        beq $v1, $t7, nn_2_3 #if(nn == 2)
                        li $t7, 3
                        beq $v1, $t7, nn_2_3 #if(nn==3)
                        li $s7, 0
                        sb $s7, newBoard($t5) 
                        beq $s7, $zero, if_end

                        nn_lt2:
                            li $s7, 0
                            sb $s7, newBoard($t5)
                            j if_end
 

                        nn_2_3:
                            li $s7, 1
                            sb $s7, newBoard($t5)
                            j if_end

                    nn_3:
                        li $s7, 1
                        sb $s7, newBoard($t5)

                    
                    if_end:
                        addi $t4, $t4, 1 #(j++)
                        j j_loop

                j_loop_end:
                    addi $t3, $t3, 1 #(i++)
                    j i_loop

            i_loop_end:
                li $v0, 4
                la $a0, resultMessage_1
                syscall

                li $v0, 1
                move $a0, $t1
                syscall

                li $v0, 4
                la $a0, resultMessage_2
                syscall


                jal copyBackAndShow

                addi $t1, $t1, 1 #iterate by 1 (n++)
                j n_loop

        n_loop_end:
            beq $t1, $t0, main_final
    
    main_final: 

        li $v0, 4
        la $a0, resultMessage_1
        syscall

        li $v0, 1
        lw $a0, maxiters
        syscall

        li $v0, 4
        la $a0, resultMessage_2
        syscall
  
        #jump to function copyBackAndShow
        jal copyBackAndShow

   
# Your main program code goes here

end_main:
    lw   $ra, main_ret_save
    jr   $ra

    li $v0, 10
    syscall

# The other functions go here
#-----------------------------------------------------
    .globl neighbours 
neighbours:
    lw $t5, nn_neighbours

    li $t6, 1 #t6 is our constant 1
    li $t7, -1 #t7 is our counter x
    li $t8, -1 #t8 is our counter y
    lw $s3, N
    li $t9, 1
    sub $t9, $s3, $t9
    x_loop: 
        ble $t7, $t6, x_loop_end

        li $t8, -1
        y_loop:
            ble $t8, $t6, y_loop_end

            #a1 = i && a2 = j
            add $a1, $t7, $a1
            add $a2, $t8, $a2

            #$a1 = x+i
            #$a2 = j+y
            #if statements
            blt $a1, $zero, if_2 #if(x+i)<0 continue
            ble $a1, $t9, if_fail #if(x+i)>N-1 continue

            if_2:
                blt $a2, $zero, if_3 #if(y+j)<0 continue
                ble $a2, $t9, if_fail #if(y+j)>N-1 continue

            if_3:    
                bne $t7, $zero, if_fail #if(x==0) continue
                bne $t8, $zero, if_fail #if (y==0) continue

            
            mul $s4, $s3, $a1 #N*(x+i)
            add $s4, $s4, $a2 #(N*(x+i))+(j+y)
            lb $s5, board($s4)

            li $s3, 1
            bne $s5, $s3, if_fail #if(board[x+i][y+j] == 1 continue
            addi $t5, $t5, 1

            if_fail:
                addi $t8, $t8, 1 #y++
                j y_loop

            y_loop_end:
                addi $t7, $t7, 1 #x++
                j x_loop

        x_loop_end:
            move $v1, $t5
            jr $ra



#-----------------------------------------------------
    .globl copyBackAndShow
copyBackAndShow:
    lw $t6, N#t6 is our constant N
    li $t7, 0 #t7 is our counter i
    li $t8, 0 #t8 is our counter j
    loop_1: 
        ble $t6, $t7, loop_1_end

        li $t8, 0
        loop_2:
            ble $t6, $t8, loop_2_end

            mul $t5, $t6, $t7
            add $t5, $t5, $t8
            lb $s0, board($t5)
            lb $s1, newBoard($t5)

            sb $s1, board($t5)
            beq $s1, $zero, print_period

            li $v0, 4
		    la $a0, char_hash
		    syscall

            print_period:
                li $v0, 4
                la $a0, char_period
                syscall
            

            addi $t8, $t8, 1
            j loop_2

        loop_2_end:
            li $v0, 4
            la $a0, char_newline
            syscall
                
            addi $t7, $t7, 1
            j loop_1

    loop_1_end:
        jr $ra

