#Name: Tony Diaz, Xavier Felix, Tanay Shah, Clifton Williams
#Date 4/5/2023
#Assignment: Program 2: Practice with Conditionals and Loops
#Objectives
# Display main mento to user
# take int input from user
# Depening on input and ask for grade percentage
# based on inputted value display the correct grade letter to the user

.data
dashes: .asciiz "\n--------------------------------------------\n"
mainMenu: .asciiz "---------------MAIN MENU---------------\n"
usrMenu: .asciiz "1)Get letter Grade\n2)Exit Program\n\nEnter '1' or '2' for your selection: "
prompt1: .asciiz "\nPlease enter a score as an integer value: "
prompt2: .asciiz "\nThe grade is: "
rePromptMenu: .asciiz "\nWould you like to enter a new score\n(Y)Yes (N)No\n\nEnter 'Y' or 'N' for your selection:"

buffer: .space 30
gradeA: .asciiz "A"
gradeB: .asciiz "B"
gradeC: .asciiz "C"
gradeD: .asciiz "D"
gradeF: .asciiz "E"
invalidInput: "\nInvalid input, please choose the correct selection\n"
.text
main:
	#shows the "----------main menu----------" with the dashes
	li $v0, 4
	la $a0, mainMenu
	syscall

	#shows actual user main menu
	li $v0, 4
	la $a0, usrMenu
	syscall
	
	#recieves user input
	li $v0, 5
	syscall
	move $s0, $v0
	
	#Returns a grade or exits the program
	beq $s0, 1, processGrade
	beq $s0, 2, exit
	
	#the case for a differnt input other than 1 or 2

processGrade:
	li $v0, 4
	la $a0, dashes
	syscall 
	
	#please enter a score as an integer value
	li $v0, 4
	la $a0, prompt1
	syscall 
	
	#here I will grab the integer and throw a grade
	li $v0, 5
	syscall
	move $s1, $v0
	
	#The grade is:
	li $v0, 4
	la $a0, prompt2
	syscall
	
	bgt $s1, 89, grade_A
	bgt $s1, 79, grade_B
	bgt $s1, 69, grade_C
	bgt $s1, 59, grade_D
	
	j INVALID
	
reTry:
	#would you like to enter a new score?
	li $v0, 4
	la $a0, rePromptMenu
	syscall
	
	#Takes in a string from the user and puts it in the buffer
	li $v0, 8
	la $a0, buffer
	li $a1, 10
	syscall
	
	#loads a register form the buffer and then compares the register to either 'Y' or 'y' if it is then reloop the program 
	lb $s2, buffer
	beq $s2, 'Y', processGrade
	beq $s2, 'y', processGrade
	beq $s2, 'N', main
	beq $s2, 'n', main
	
	j INVALID

INVALID: 
	#would you like to enter a new score?
	li $v0, 4
	la $a0, invalidInput
	syscall

	
	#would you like to enter a new score?
	li $v0, 4
	la $a0, rePromptMenu
	syscall
	
	#Takes in a string from the user and puts it in the buffer
	li $v0, 8
	la $a0, buffer
	li $a1, 10
	syscall
	
	#loads a register form the buffer and then compares the register to either 'Y' or 'y' if it is then reloop the program 
	lb $s2, buffer
	beq $s2, 'Y', processGrade
	beq $s2, 'y', processGrade
	beq $s2, 'N', main
	beq $s2, 'n', main
	
	j INVALID
	
grade_A:
	li $v0, 4
	la $a0, gradeA
	syscall
	
	li $v0, 4
	la $a0, dashes
	syscall 
	
	j reTry

grade_B:
	li $v0, 4
	la $a0, gradeB
	syscall
	
	li $v0, 4
	la $a0, dashes
	syscall 
	
	j reTry

grade_C:
	li $v0, 4
	la $a0, gradeC
	syscall
	
	li $v0, 4
	la $a0, dashes
	syscall 
	
	j reTry

grade_D:
	li $v0, 4
	la $a0, gradeD
	syscall
	
	li $v0, 4
	la $a0, dashes
	syscall 
	
	j reTry
	
exit:
	li $v0, 10
	syscall