#Name: Tony Diaz, Xavier Felix, Tanay Shah, Clifton Williams
#Date 4/5/2023
#Assignment: Program 2: Practice with Conditionals and Loops
#Objectives
# Display main mento to user
# take int input from user
# Depening on input and ask for grade percentage
# based on inputted value display the correct grade letter to the user

.data
mainMenu: .asciiz "--------------- MAIN MENU ---------------\n1) Get Letter Grade\n2) Exit\nEnter '1' or '2' for your selection: "
gradeIn: .asciiz "-----------------------------------------\nPlease enter score as integer value\nEnter integer between 0 and 100: "
gradeA: .asciiz "The grade is: A"
gradeB: .asciiz "The grade is: B"
gradeC: .asciiz "The grade is: C"
gradeD: .asciiz "The grade is: D"
gradeF: .asciiz "The grade is: E"
newScore: .asciiz "-----------------------------------------\nWould you like to enter a new score?\nY) Yes\nN) No\n Enter 'Y' or 'N' for your selection: "
reprompt: .asciiz "Invalid input, please select one of the inputs provided: "
exitMessage: .asciiz "The program will now exit."

.text
main:
	#display main menu
	li $v0, 4
	la $a0, mainMenu
	syscall
	
	#read user input
	li $v0, 5	
	syscall
	move $t0, $v0	#$t0 stores user input
	
	#branch to check if user input is less than 1 or greater than 2
	blt $t0, 1, mainMenuReprompt
	bgt $t0, 2, mainMenuReprompt
	#branch to check if user input is 1
	beq $t0, 1, looping
	#branch to check if user input is 2 to exit program
	beq $t0, 2, exit

mainMenuReprompt:
	#display reprompt
	li $v0, 4
	la $a0, reprompt
	syscall
	
	#read user input
	li $v0, 5	
	syscall
	move $t0, $v0	#$t0 stores user input
	
	#branch to check if user input is less than 1 or greater than 2
	blt $t0, 1, mainMenuReprompt
	bgt $t0, 2, mainMenuReprompt
	#branch to check if user input is 1
	beq $t0, 1, looping

gradeLooping:
	#display grade menu
	li $v0, 4
	la $a0, gradeIn
	syscall

	#read user input
	li $v0, 5	
	syscall
	move $t0, $v0	#$t0 stores user input
	
gradeLoopingReprompt:

exit:
	#exit message
	li $v0, 4
	la $a0, exitMessage
	syscall
	
	#exit
	li $v0, 10
	syscall