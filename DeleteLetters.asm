	.data
text1:	.asciiz "Enter frist string: \n"
text2:	.asciiz "Enter second string: \n"
text3:	.asciiz "Result: \n"
buf1:	.space 100
buf2:	.space 100
	.text
	.globl main
main:
	la $a0, text1
	li $v0, 4
	syscall
	la $a0, buf1
	la $a1, 100
	li $v0, 8
	syscall
	la $a0, text2
	li $v0, 4
	syscall
	la $a0, buf2
	li $v0, 8
	syscall
	
	la $t1, buf1	#t1 - adres poczatkowy slowa docelowego
	la $t3, buf2	#t3 - adres aktualny liter zakazanych
	lb $t6, ($t1)
	beqz $t6, end
	lb $t6, ($t3)
	beqz $t6, end
	
	move $t2, $t1	#t2 - adres aktualnej litery slowa docelowego
	move $t0, $t2	#t0 - flaga gdzie skonczylismy
	
prepMvAndComp:
	lb $t4, ($t2)	#t4 - wartosc w slowie docelowym
	lb $t5, ($t3)	#t5 - wartosc w slowie liter zakazanych
mvAndComp:
	beq $t4, $t5, prepSwap
	addi $t3, $t3, 1
	lb $t5, ($t3)
	beqz $t5, next
	j mvAndComp
	
prepSwap:
	move $t0, $t2	#t0 - flaga gdzie skonczylismy
swap:
	beq $t1, $t2, preNext
	lb $t6, ($t2)
	subi $t2, $t2, 1
	lb $t7, ($t2)
	sb $t6, ($t2)
	addi $t2, $t2, 1
	sb $t7, ($t2)
	subi $t2, $t2, 1
	j swap
preNext:
	addi $t1, $t1, 1
	move $t2, $t0
next:
	la $t3, buf2
	addi $t2, $t2, 1
	lb $t6, ($t2)
	beqz $t6, end
	j prepMvAndComp
end:
	li $v0, 4
	la $a0, text3
	syscall
	la $a0, ($t1)
	syscall
	li $v0, 10
	syscall
