# COMP1521 Practice Prac Exam #1
# int lowerfy(char *src, char *dest)

   .text
   .globl lowerfy

# params: src=$a0, dest=$a1
lowerfy:
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
   # if you need to save more $s? registers
   # add the code to save them here

# function body
# locals: src=$s0, dest=$s1, i=$s2, n=$s3, ch=$t0

   # add code for your lowerfy function here
   move $s0, $a0
   move $s1, $a1
   move $s2, $0
   move $s3, $0

lower_loop:
   move $t0, $s0
   add  $t0, $t0, $s2
   lb   $t0, ($t0)       # ch = src[i]
   beqz $t0, end_lower_loop

   li   $t1, 'A'
   blt  $t0, $t1, next_lower_loop
   li   $t1, 'Z'
   bgt  $t0, $t1, next_lower_loop

   li   $t1, 'a'
   add  $t0, $t0, $t1
   li   $t1, 'A'
   sub  $t0, $t0, $t1    # ch = ch + 'a' - 'A'

   addi $s3, $s3, 1      # n++

next_lower_loop:
   move $t1, $s1
   add  $t1, $t1, $s2
   sb   $t0, ($t1)       # dest[i] = ch

   add  $s2, $s2, 1      # i++
   j    lower_loop

end_lower_loop:
   move $t0, $s1
   add  $t0, $t0, $s2
   move $t1, $0
   sb   $t1, ($t0)

   move $v0, $s3         # return n

# epilogue
   # if you saved more than two $s? registers
   # add the code to restore them here
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
