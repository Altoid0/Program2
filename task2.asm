#take in two ints from the user
#one int will be x
#another int will be y
#make sure the user knows which value is x and y
#find the result of x to the power of y and output the result

#main label, a looping label, and exit label, loop counter

.data
description: .asciiz "This program asks the user to input a value for 'x' and 'y'.\nThen, it finds the value of x to the power of y.\nFor example, 2 to the power 3 is 8.\n\n"
ask_x: .asciiz "Enter a number for 'x': "
ask_y: .asciiz "\nEnter a number for 'y': "
result: .asciiz "'x' to the power 'y' is: "
.text
main: 
	#Description of program
	li $v0, 4
	la $a0, description
	syscall

	#Asking to enter a number for x
	li $v0, 4
	la $a0, ask_x
	syscall
	
	#Take in that number for x
	li $v0, 5
	syscall
	move $s0, $v0
	
	#Asking to enter a number for y
	li $v0, 4
	la $a0, ask_y
	syscall
	
	#Take in that number for y
	li $v0, 5
	syscall
	move $s1, $v0
	
	#prints the result prompt
	li $v0, 4
	la $a0, result
	syscall
	
	#initializing $t7 as loop counter (i = 1)
	addi $t7, $t7, 1
	
	#Creating a copy of the base into $s2, then using it to store each evaluation
	move $s2, $s0
	
	j evaluate
	
	
evaluate:
	beq $s1, 1, printResult
	beq $s1, $zero, printOne
	
	mult $s2, $s0
	
	mfhi $t0
	mflo $t1
	
	add $s2, $t0, $t1
	
	addi $t7, $t7, 1
	blt $t7, $s1, evaluate
	
	
	j printResult
	
printResult:	
	li $v0, 1
	move $a0, $s2
	syscall
	
	j exit
	
printOne:
	addi $s1, $s1, 1
	
	li $v0, 1
	move $a0, $s1
	syscall
	
	j exit
	
exit:
	li $v0, 10
	syscall
