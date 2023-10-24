.data
    operand1: .word 4
.text

Main:
  la $t0, operand1     
  lw $t1, 0($t0)
  ble $t1,1 Less_Than_1  
  move $t4, $zero  
  Init_Loop:
     subi $t5, $t1, 1   
     subi $t6, $t1, 1   
     j Loop  
  Loop_Setting:
     ble  $t6,1 End  
     subi $t6, $t6,  1
     move $t5, $t6  
     move $t1, $t4
     move $t4, $zero
     j Loop
  Loop:
    beqz $t5,  Loop_Setting      	
    add $t4, $t4, $t1  
    addi $t5, $t5, -1  
    j Loop  
  Less_Than_1:
    addi $t4, $t4, 1         
  End: 
    li $v0, 1         
    move $a0, $t4        
    syscall  
      
    li $v0, 10
    syscall
  
