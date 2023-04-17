# Name: Tony Diaz, Xavier Felix, Tanay Shah, Clifton Williams
# Date 4/5/2023
# Assignment: Program 2: Practice with Conditionals and Loops
# Objectives
#   take in two ints from the user
#   one int will be x
#   another int will be y
#   make sure the user knows which value is x and y
#   find the result of x to the power of y and output the result

#main label, a looping label, and exit label, loop counter

.data
description: .asciiz "This program asks the user to input a value for 'x' and 'y'.\nThen, it finds the value of x to the power of y.\nFor example, 2 to the power 3 is 8.\n"
askX: .asciiz "\nEnter a number for 'x': "
askY: .asciiz "\nEnter a number for 'y': "
result: .asciiz "\n'x' to the power 'y' is: "

.text
main: 
	#Description of program
	li $v0, 4
	la $a0, description
	syscall

	#Asking to enter a number for x
	li $v0, 4
	la $a0, askX
	syscall
	
	#Take input for x and store it in $s0
	li $v0, 5
	syscall
	move $s0, $v0
	
	#Asking to enter a number for y
	li $v0, 4
	la $a0, askY
	syscall
	
	#Take input for y and store it in $s1
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
    # if y = 1, then result is x
	beq $s1, 1, printResult
    
    # if y = 0, then result is 1
	beq $s1, $zero, printOne

	# else we need to multiply x by itself y times

    # multiply x by itself since we already have a copy of x in $s2
	mult $s2, $s0
	
    # grab the hi and lo bits of the result
	mfhi $t0
	mflo $t1
	
    # add the hi and lo bits together to get the result
	add $s2, $t0, $t1
	
    # increment the loop counter
	addi $t7, $t7, 1

    # jump to evaluate if the loop counter is less than y
	blt $t7, $s1, evaluate
	
	# loop is done, print the result
	j printResult
	
printResult:
    # print the result
	li $v0, 1
	move $a0, $s2
	syscall
	
    # exit the program
	j exit
	
printOne:
    # print 1 since y = 0
	addi $s1, $s1, 1
	
	li $v0, 1
	move $a0, $s1
	syscall

    # exit the program	
	j exit
	
exit:
    # exit the program
	li $v0, 10
	syscall
