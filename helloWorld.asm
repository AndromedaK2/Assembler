.data
	numero: .word 5
.text

	main:
	
	
	li $v0, 1
	lw $a0, numero
	syscall
	
	li $v0, 10
	syscall
	