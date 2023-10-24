.data
dividend:     .word 10
divisor:      .word -22
quotient:     .word 0
remainder:    .word 0
decimalList:  .space 16
precision:    .word 3
decimalPlaces: .word 0
output_remainder: .asciiz " Remainder: "
output_value:     .asciiz " Quotient: "
negative:         .asciiz "-"
comma: .asciiz "."
zero: .word 0 

.text
.globl main
main:
    la $t0, dividend      
    lw $t1, 0($t0)         # Load dividend value into $t1

    la $t0, divisor       
    lw $t2, 0($t0)         # Load divisor value into $t2
          
    lw $t9, decimalPlaces  # Load decimalPlaces
    lw $t8, precision
  
    la $t0, quotient       # Load address of quotient
    la $t3, remainder      # Load address of remainder
   
    move $t4, $zero        # Initialize counter to 0
    xor $t7, $t1, $t2      # Load sign
    abs $t1, $t1           # Convert to positive
    abs $t2, $t2    
     
    blt $t1, $t2, exit_div_loop  # Exit loop if dividend is less than divisor
    j div_loop

    div_loop:
	sub $t1, $t1, $t2    # Subtract divisor from dividend
        	addi $t4, $t4, 1     # Increment counter by 1

        	blt $t1, $t2, exit_div_loop  # Exit loop if dividend is less than divisor
       	j div_loop

    exit_div_loop:
    
    	sw $t4, 0($t0)           # Store quotient
    	sw $t1, 0($t3)           # Store remainder
   	addi $s1, $zero,0        # Store counter decimalList
    	j loop_decimal

   loop_decimal:
    
    	bgt $t9, $t8 print_values
    	beqz $t1, print_values
    	
    	#mul  $t1, $t1, 10  # dividen * 10
    	addi $s6, $zero, 10
    	addi $t4, $zero, 0
	jal multiplication 	
	
	move $t1, $t4
    	move $s0, $zero  # decimalDigit
	
	jal calculate	
	sw $s0, decimalList($s1)
	 	
    	addi $t9, $t9, 1
    	addi $s1, $s1, 4  
    	
    	j loop_decimal
    multiplication:	   
    	 add $t4, $t4, $t1
   	 addi $s6, $s6, -1  
   	 bgtz $s6, multiplication 
    	 jr $ra    				
    calculate:
	sub $t1, $t1, $t2    # Subtract divisor from dividend
        	addi $s0, $s0, 1     # Increment counter by 1
        	bge  $t1, $t2 calculate  # Exit loop if dividend is less than divisor
       	jr $ra
    print_values:     
	li $v0, 4                # Print string
	la $a0, output_remainder # Load address of remainder output string
    	syscall

    	li $v0, 1                # Print integer
    	lw $a0, 0($t3)           # Load remainder value into $a0
    	syscall
   

	j print_quotient    

    
    print_quotient:
        	li $v0, 4                # Print string
	la $a0, output_value      # Load address of final value output string
    	syscall
    	
    	bgtz $t7,  print_quotient_aux   
    	
    	li $v0, 4                # Print string
	la $a0, negative         # Load address of final value output string
    	syscall
   
  
    	j print_quotient_aux 
   
    print_quotient_aux:
    	li $v0, 1                # Print integer
    	lw $a0, 0($t0)           # Load quotient value into $a0
    	syscall

    	li $v0, 4                # Print string
	la $a0, comma     # Load address of final value output string
    	syscall

    	addi $t0, $zero, 0
  
    	j print_decimals   
    print_decimals: 
    	beq $t0, 16, exit
    	lw $t6, decimalList($t0)
    	
    	addi $t0, $t0, 4 
    	
    	li $v0, 1
    	move $a0, $t6
    	syscall
    	
    	j print_decimals
  
    exit:  li $v0, 10               # Exit program
    	syscall
    	 	      	    	      	   
    
