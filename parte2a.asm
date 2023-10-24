.data
  operand1: .word 0 
  operand2: .word 10

.text

Main:
  la $t0, operand1     
  lw $s1, 0($t0)       

  la $t2, operand2    
  lw $s3, 0($t2)       

  move $t4, $zero 
  
  abs $t1, $s1
  abs $t3, $s3    

  Loop:
    beqz $t3, End_Loop     
    	
    add $t4, $t4, $t1  
    addi $t3, $t3, -1  

    j Loop            

  End_Loop:

     xor $t5, $s1, $s3    
     bltz $t5, Negate     
 
     j End

  Negate:
     neg $t4, $t4      
     j End
     
  End:
  
     li $v0, 1         
     move $a0, $t4        
     syscall  
      
     li $v0, 10
     syscall
     
     
     
     
     
