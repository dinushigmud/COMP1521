# COMP1521 Lab 04 ... Simple MIPS assembler


### Global data

   .data
msg1:
   .asciiz "n: "
msg2:
   .asciiz "n! = "
eol:
   .asciiz "\n"
factorial:
	.space  4


### main() function

   .data
   .align 2
main_ret_save:
   .word 4

   .text
   .globl main

main:
   sw   $ra, main_ret_save

#  ... your code for main() goes here
	la $a0, msg1 
	li $v0, 4
	syscall

	la $a0, factorial
	li $a1, 4
	li $v0, 5
	syscall

	move $a0, $v0 			#mov scanned value to t1
	jal fac

   lw   $ra, main_ret_save
   jr   $ra           # return



### fac() function

   .data
   .align 2
fac_ret_save:
   .space 4

   .text

fac:
   sw   $ra, fac_ret_save

#  ... your code for fac() goes here
	move $t1, $a0
	li $t2, 1				#t2=1
	li $t0, 0
	fac_loop:
		mul $t2 $t2 $t1 	#t2 = t2*t1 
		addi $t1, $t1, -1	#t1 = t1-1
		bgt $t1,$t0,fac_loop

	end_loop:
		la $a0, msg2
		li $v0, 4
		syscall 

		la $a0, ($t2)
		li $v0, 1
		syscall

		la   $a0, eol
   		li   $v0, 4        # printf("\n");
   		syscall


   lw   $ra, fac_ret_save
   jr   $ra            # return ($v0)

