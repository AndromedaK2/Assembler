.data
	a: .word 0
	z: .word 1
.text
	main: 
  		lw $t0,a($0) # cargar dato1 en t0
		lw $t1,z($0) # cargar dato2 en t1
		
		while: 
   			 beq  $t1, 10, exit
   			 add  $t0, $t0, $t1
   	 		
   			 addi $t1, $t1,1	
   			 li $v0, 1
   			 move $a0, $t1	
   			 syscall
   			 
   			 j    while 
   		exit:
			li $v0, 10
			syscall

