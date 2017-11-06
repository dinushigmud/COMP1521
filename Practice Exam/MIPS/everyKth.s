# COMP1521 Practice Prac Exam #1
# int everyKth(int *src, int n, int k, int*dest)

   .text
   .globl everyKth

# params: src=$a0, n=$a1, dest=$a2
everyKth:
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
# locals: src=$s0, n=$s1, k=$s2, dest=$s3, i=$s4, j=$s5
   move $s0, $a0
   move $s1, $a1
   move $s2, $a2
   move $s3, $a3
   li   $s4, 0                # i = 0
   li   $s5, 0                # j = 0

everyK_for:
   bge  $s4, $s1, end_everyK_for

   move $t0, $s4
   mul  $t0, $t0, 4
   add  $t0, $t0, $s0
   lw   $t2, ($t0)             # src[i]
   div  $s4, $s2
   mfhi $t0                    # i%k == 0
   bnez $t0, incr_everyK_for

   move $t0, $s5
   mul  $t0, $t0, 4
   add  $t0, $t0, $s3
   sw   $t0, ($t0)             # dest[j] = src[i]
   addi $s5, $s5, 1            # j++

incr_everyK_for:
   addi $s4, $s4, 1
   j    everyK_for
   
end_everyK_for:
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
   sw   $fp, ($sp)
   addi $sp, $sp, 4
   j    $ra
