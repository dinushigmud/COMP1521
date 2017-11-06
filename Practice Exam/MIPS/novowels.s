# COMP1521 Practice Prac Exam #1
# int novowels(char *src, char *dest)

   .text
   .globl novowels

# params: src=$a0, dest=$a1
novowels:
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
   # if you need to save more $s? registers
   # add the code to save them here

# function body
# locals: src=$s0, dest=$s1, i=$s2, j=$s3, n=$s4, ch=$s5

   # add code for your lowerfy function here
   move $s0, $a0
   move $s1, $a1
   move $s2, $0
   move $s3, $0
   move $s4, $0

nv_loop:
   move $t0, $s2
   add  $t0, $t0, $s0
   lb   $s5, ($t0)      # ch = src[i]
   move $t0, $0
   beq  $s5, $t0, end_nv_loop

   move $a0, $s5
   jal  isvowel         # isvowel(ch)
   beqz $v0, nv_not_vowel
   add  $s4, $s4, 1     # n++
   j    nv_incr
   
nv_not_vowel:
   move $t0, $s3
   add  $t0, $t0, $s1
   sb   $s5, ($t0)      # dest[j] = ch
   addi $s3, $s3, 1     # j++

nv_incr:
   addi $s2, $s2, 1
   j    nv_loop

end_nv_loop:
   move $t0, $s3
   add  $t0, $t0, $s1
   move $t1, $0
   sb   $t1, ($t0)
   move $v0, $s4

# epilogue
   # if you saved more than two $s? registers
   # add the code to restore them here
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

# int isvowel(char ch)
isvowel:
# prologue
   addi $sp, $sp, -4
   sw   $fp, ($sp)
   la   $fp, ($sp)
   addi $sp, $sp, -4
   sw   $ra, ($sp)

# function body
   li   $t0, 'a'
   beq  $a0, $t0, match
   li   $t0, 'A'
   beq  $a0, $t0, match
   li   $t0, 'e'
   beq  $a0, $t0, match
   li   $t0, 'E'
   beq  $a0, $t0, match
   li   $t0, 'i'
   beq  $a0, $t0, match
   li   $t0, 'I'
   beq  $a0, $t0, match
   li   $t0, 'o'
   beq  $a0, $t0, match
   li   $t0, 'O'
   beq  $a0, $t0, match
   li   $t0, 'u'
   beq  $a0, $t0, match
   li   $t0, 'U'
   beq  $a0, $t0, match

   li   $v0, 0
   j    end_isvowel
match:
   li   $v0, 1
end_isvowel:

# epilogue
   lw   $ra, ($sp)
   addi $sp, $sp, 4
   lw   $fp, ($sp)
   addi $sp, $sp, 4
   j    $ra