# COMP1521 Practice Prac Exam #1
# int dotProd(int *a1, int n1, int *a2, int n2)

   .text
   .globl dotProd

# params: a1=$a0, n1=$a1, a2=$a2, n2=$a3
dotProd:
# prologue
   addi $sp, $sp, -4
   sw   $fp, ($sp)
   la   $fp, ($sp)
   addi $sp, $sp, -4
   sw   $ra, ($sp)
   addi $sp, $sp, -4
   sw   $s0, ($sp)
   addi $sp, $sp, -4
   sw   $s1, ($sp)
   addi $sp, $sp, -4
   sw   $s2, ($sp)
   addi $sp, $sp, -4
   sw   $s3, ($sp)
   addi $sp, $sp, -4
   sw   $s4, ($sp)
   addi $sp, $sp, -4
   sw   $s5, ($sp)
   addi $sp, $sp, -4
   sw   $s6, ($sp)
   # if you need to save more $s? registers
   # add the code to save them here

# function body
# locals: a1=$s0, n1=$s1, a2=$s2, n2=$s3
#         i=$s4, len=$s5, sum=$s6

   # add code for your dotProd function here

   move $s0, $a0
   move $s1, $a1
   move $s2, $a2
   move $s3, $a3
   move $s4, $0
   move $s6, $0

   blt  $s1, $s3, dp_less
   move $s5, $s3
   j    dp_loop
dp_less:
   move $s5, $s1

dp_loop:
   bge  $s4, $s5, end_dp_loop

   move $t0, $s4
   li   $t1, 4
   mul  $t0, $t0, $t1

   add  $t1, $t0, $s0
   lw   $t1, ($t1)      # a1[i]
   
   add  $t2, $t0, $s2
   lw   $t2, ($t2)      # a2[i]

   mul  $t0, $t1, $t2
   add  $s6, $s6, $t0   # sum += a1[i]*a2[i]
   
   addi $s4, $s4, 1
   j    dp_loop
end_dp_loop:
   move $v0, $s6
   move $v1, $s5

# epilogue
   # if you saved more than two $s? registers
   # add the code to restore them here
   lw   $s6, ($sp)
   addi $sp, $sp, 4
   lw   $s5, ($sp)
   addi $sp, $sp, 4
   lw   $s4, ($sp)
   addi $sp, $sp, 4
   lw   $s3, ($sp)
   addi $sp, $sp, 4
   lw   $s2, ($sp)
   addi $sp, $sp, 4
   lw   $s1, ($sp)
   addi $sp, $sp, 4
   lw   $s0, ($sp)
   addi $sp, $sp, 4
   lw   $ra, ($sp)
   addi $sp, $sp, 4
   lw   $fp, ($sp)
   addi $sp, $sp, 4
   j    $ra
