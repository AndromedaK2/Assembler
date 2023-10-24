.data
a: .word 0
z: .word 1
newLine: .asciiz "\n"

.text
.globl main

main:
	lw $t0,a($0) # cargar dato1 en t0
	lw $t1,z($0) # cargar dato2 en t1	
while:
    	bne $t1, 10, go 
   	j exit
go:
   	add  $t0, $t0, $t1   	 		
  	addi $t1, $t1,1	
  	
  	# Imprimir Numero
  	li $v0, 1
   	move $a0, $t1	
	syscall
	
	# Imprimir Nueva Linea
	li $v0, 4
	la $a0, newLine
	syscall
	
	j while
exit:
	li $v0, 10
	syscall
