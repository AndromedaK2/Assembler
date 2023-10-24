.data
	prompt1: .asciiz "Por favor ingrese el primer entero:"
	prompt2: .asciiz "Por favor ingrese el segundo entero:"
	message: .asciiz "La diferencia es: "
	even_message: .asciiz "El numero es par: "
	odd_message:  .asciiz "El numero es Impar: "
	
.text
	Main:       # save first number
		li $v0 4
		la $a0, prompt1
		syscall	
		li $v0 5
		syscall     
		move $t0, $v0 
		
         	           # save second number		
		li $v0 4
		la $a0, prompt2
		syscall		
		li $v0 5
		syscall        	       
		move $t1, $v0 
		
		#Call function calculate
		move $a0, $t0
		move $a1, $t1
		jal Calculate
		move $s0, $v0 
			
		
		andi $s1, $s0, 1  
		beqz $s1, Even   # branch equal to zero
		
		j Odd
	Calculate:
		sub $v0, $a0, $a1
		abs $v0, $v0
		jr $ra
	Even:	        	
		li $v0,4
		la $a0, even_message	
		syscall
		
        		li $v0, 1         
        		move $a0, $s0        
       		syscall
       		
       		j Exit
	Odd:
		li $v0, 4
		la $a0, odd_message
		syscall
		
        		li $v0, 1         
        		move $a0, $s0        
       		syscall
			
		j Exit
	Exit: 
		li $v0, 10
		syscall
