.data
list: .word 2, 3, 5, 7, 11, 13, 17, 19, 23, 29
size: .word 10
.text
.globl main
main:
	la $t1, list # get array address
	li $t2, 0 # set loop counter
print_loop:
	beq $t2, $t3, print_loop_end # check for array end
	lw $a0, ($t1) # print value at the array pointer
	li $v0, 1
	syscall
	addi $t2, $t2, 1 # advance loop counter
	addi $t1, $t1, 4 # advance array pointer
	j print_loop # repeat the loop
print_loop_end: