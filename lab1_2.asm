.data
	a: .word 0
	b: .word 0
	D: .space 40 # definir arreglo de 10 enteros cada entero pesa 4 bytes por eso se multiplica x4
	newLine: .asciiz "\n"
.text
.globl main
	main:
		lw $s0, a($0)  # cargar a en s0
		lw $s1, b($0)  # cargar b en s1
		la $s2, D     # carrgar dirección base del arreglo en s2 			
		
	while:
		blt $s0, 10, go
		j exit
	go:
		# multiplicar el valor de a por 4 primera itercion a = 0
		sll $t0, $s0, 2  
		add $t0, $t0, $s2
		
		add $t1, $s0, $s1
		sw $t1, ($t0)
		lw $a0, 0($t0)
		# Imprimir Numero
  		li $v0, 1
		syscall
	
		# Imprimir Nueva Linea
		li $v0, 4
		la $a0, newLine
		syscall	
			
			
		addi $s0, $s0, 1	
		j while	
	exit:
		li $v0, 10
		syscall
		
		
	