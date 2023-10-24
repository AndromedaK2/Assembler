.data
arr: .word 10 22 15 40 80 99 110 550 777 820 891 902 100
end:
i: 0
evensum: 0
newLine: .asciiz "\n" 
.text
 	# esta instrucción pone la dirección base de arr en $s0
	la $s0, arr
	la $s1, end	
	
	# resta sin signo
	subu $s1, $s1, $s0
	
	# ahora $s1 = num elementos en arreglo
	srl $s1, $s1, 2 
	
	#Inicializar Variables
	lw $t0, i($0)  # i
	lw $t1, evensum($0) # evensum
	la $t2, ($s0)    # direccion de memoria inicializa en t2
loop:
	beq  $t0, $s1 exit # si son iguales se termina la operacion
	lw   $t5, ($t2)
	and  $t3, $t5, 1   # par o no
	beq  $t3, 0 sum
	j continue
sum:   	
	# sumando en evensum	
	add $t1, $t1, $t5 	
	
	# imprimir valor	
	li $v0, 1 
	move $a0, $t1
	syscall
	
	# Imprimir Nueva Linea
	li $v0, 4
	la $a0, newLine
	syscall
				
	j continue
continue:
	# Avanzar al siguiente elemento
	addi $t2,$t2,4	
	#suma 1 al contador
	addi $t0,$t0,1 
	j loop
exit:	
	li $v0, 10
	syscall
