    # MIPS assembler to compute Fibonacci numbers

    .data
    msg1:
    .asciiz "n = "
    msg2:
    .asciiz "fib(n) = "

    error_msg: .asciiz "n must be > 0 "

    .text

    # int main(void)
    # {
    #    int n;
    #    printf("n = ");
    #    scanf("%d", &n);
    #    if (n >= 1)
    #       printf("fib(n) = %d\n", fib(n));
    #    else {
    #       printf("n must be > 0\n");
    #       exit(1);
    #    }
    #    return 0;
    # }

    .globl main
    main:
    # prologue
    addi $sp, $sp, -4
    sw   $fp, ($sp)
    move $fp, $sp
    addi $sp, $sp, -4
    sw   $ra, ($sp)

    # function body
    la   $a0, msg1       # printf("n = ");
    li   $v0, 4
    syscall

    li   $v0, 5          # scanf("%d", &n);
    syscall
    move $a0, $v0

    li $t0, 1
    bge $a0, $t0, error
    # ... add code to check (n >= 1)
    
    error:
        la $a0, error_msg
        li $v0, 4
        syscall

        li $a0, 0
            
    # ... print an error message, if needed
    # ... and return a suitable value from main()

    jal  fib             # $s0 = fib(n);
    nop
    move $s0, $v0

    la   $a0, msg2       # printf((fib(n) = ");
    li   $v0, 4
    syscall

    move $a0, $s0        # printf("%d", $s0);
    li   $v0, 1
    syscall

    li   $a0, "\n"       # printf("\n");
    li   $v0, 11
    syscall

    # epilogue
    lw   $ra, ($sp)
    addi $sp, $sp, 4
    lw   $fp, ($sp)
    addi $sp, $sp, 4
    jr   $ra


    # int fib(int n)
    # {
    #    if (n < 1)
    #       return 0;
    #    else if (n == 1)
    #       return 1;
    #    else
    #       return fib(n-1) + fib(n-2);
    # }

    fib:

    # Compute and return fibonacci number
    beqz $a0,zero   #if n=0 return 0
    beq $a0,1,one   #if n=1 return 1

    #Calling fib(n-1)
    sub $sp,$sp,4   #storing return address on stack
    sw $ra,0($sp)

    sub $a0,$a0,1   #n-1
    jal fib     #fib(n-1)
    add $a0,$a0,1

    lw $ra,0($sp)   #restoring return address from stack
    add $sp,$sp,4
    sub $sp,$sp,4   #Push return value to stack
    sw $v0,0($sp)

    #Calling fib(n-2)
    sub $sp,$sp,4   #storing return address on stack
    sw $ra,0($sp)

    sub $a0,$a0,2   #n-2
    jal fib     #fib(n-2)
    add $a0,$a0,2

    lw $ra,0($sp)   #restoring return address from stack
    add $sp,$sp,4
    lw $s7,0($sp)   #Pop return value from stack
    add $sp,$sp,4

    add $v0,$v0,$s7 # f(n - 2)+fib(n-1)
    jr   $ra

    zero:
        li $v0,0
        jr $ra

    one:
        li $v0,1
        jr $ra