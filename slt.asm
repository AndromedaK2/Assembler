.data
dato1: .word 0
dato2: .word 1
.text
main: 

lw $t0,dato1($0) # cargar dato1 en t0
lw $t1,dato2($0) # cargar dato2 en t1

while: 

   bne  $t1,  10, exit
   add  $t0, $t0, $t1
   addi $t1, $t1, 1
   j    while 

exit:
	li $v0, 10 # carga inmediata v0 para retorno de la funcion main 
	syscall