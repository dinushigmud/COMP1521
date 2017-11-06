# COMP1521 Practice Prac Exam #1
# int rmOdd(int *src, int n, int*dest)

   .text
   .globl rmOdd

# params: src=$a0, n=$a1, dest=$a2
rmOdd:
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

# function body
# locals: src=$s1, n=$s2, dest=$s3, i=$s4, j=$s5
   move $s1, $a0
   move $s2, $a1
   move $s3, $a2
   li   $s4, 0                # i = 0
   li   $s5, 0                # j = 0

rmOdd_for:
   bge  $s4, $s2, end_rmOdd_for

   move $t0, $s4
   mul  $t0, $t0, 4
   add  $t0, $t0, $s1
   lw   $t0, ($t0)             # src[i]
   move $t2, $t0
   li   $t1, 1
   and  $t0, $t0, $t1          # src[i]%2 == 0
   bnez $t0, incr_rmOdd_for

   move $t0, $s5
   mul  $t0, $t0, 4
   add  $t0, $t0, $s3
   sw   $t2, ($t0)             # dest[j] = src[i]
   addi $s5, $s5, 1            # j++

incr_rmOdd_for:
   addi $s4, $s4, 1
   j    rmOdd_for
   
end_rmOdd_for:
   move $v0, $s5

# epilogue
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
