.data
	dato1: .word 0
	dato2: .word 1
	dato3: .word 10
.text

	main:
	
		li $v0, 1
  		lw $a0, dato2($0) # cargar dato1 en t0
		syscall


