#Name: Tony Diaz, Xavier Felix, Tanay Shah, Clifton Williams
#Date 4/5/2023
#Assignment: Program 2: Practice with Conditionals and Loops
#Objectives
# Display main menu to user
# take int input from user
# Depening on input and ask for grade percentage
# based on inputted value display the correct grade letter to the user

.data
dashes: .asciiz "\n--------------------------------------------\n"
mainMenu: .asciiz "\n---------------MAIN MENU---------------\n"
usrMenu: .asciiz "1)Get letter Grade\n2)Exit Program\n\nEnter '1' or '2' for your selection: "
prompt1: .asciiz "\nPlease enter a score as an integer value: "
prompt2: .asciiz "\nThe grade is: "
rePromptMenu: .asciiz "\nWould you like to enter a new score\n(Y)Yes (N)No\n\nEnter 'Y' or 'N' for your selection:"

buffer: .space 30
gradeA: .asciiz "A"
gradeB: .asciiz "B"
gradeC: .asciiz "C"
gradeD: .asciiz "D"
gradeF: .asciiz "F"
invalidInput: "\nInvalid input, please choose the correct selection\n"
invalidMenu: "\nInvalid menu input, please choose either 1 or 2\n"
exitPrompt: .asciiz "\nThe program will now exit."
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
    #case for an input other than 1 or 2
    bgt $s0, 2, invalidMainMenuOption
	blt $s0, 1, invalidMainMenuOption

invalidMainMenuOption:
    li $v0, 4
    la $a0, invalidMenu
    syscall

    j main


processGrade:
	#prints dashes for visual separation
	li $v0, 4
	la $a0, dashes
	syscall 
	
	#prints: please enter a score as an integer value
	li $v0, 4
	la $a0, prompt1
	syscall 
	
	#Get user input as an integer and store it in $s1 for later comparison
	li $v0, 5
	syscall
	move $s1, $v0
	
	#prints: The grade is:
	li $v0, 4
	la $a0, prompt2
	syscall
	
	#compares the inputted value to the grade values and jumps to the appropriate label
	bgt $s1, 89, grade_A
	bgt $s1, 79, grade_B
	bgt $s1, 69, grade_C
	bgt $s1, 59, grade_D
	bgt $s1, 0, grade_F
	
	j invalid
	
reTry:
	#Ask the user if they would like to enter a new score
	li $v0, 4
	la $a0, rePromptMenu
	syscall
	
	#Takes in a string from the user and puts it in the buffer
	li $v0, 8
	la $a0, buffer
	li $a1, 10
	syscall
	
	#loads a register from the buffer, compares and then jumps to appropriate label
	lb $s2, buffer
	beq $s2, 'Y', processGrade
	beq $s2, 'y', processGrade
	beq $s2, 'N', main
	beq $s2, 'n', main
	
	j invalid

invalid: 
	#prints invalid input prompt
	li $v0, 4
	la $a0, invalidInput
	syscall

	j reTry

grade_A:
	#Prints the grade A
	li $v0, 4
	la $a0, gradeA
	syscall
	
	#Prints the dashes
	li $v0, 4
	la $a0, dashes
	syscall 
	
	#Ask the user if they want to enter a new score
	j reTry

grade_B:
	#Prints the grade B
	li $v0, 4
	la $a0, gradeB
	syscall
	
	#Prints the dashes
	li $v0, 4
	la $a0, dashes
	syscall 
	
	#Ask the user if they want to enter a new score
	j reTry

grade_C:
	#Prints the grade C
	li $v0, 4
	la $a0, gradeC
	syscall
	
	#Prints the dashes
	li $v0, 4
	la $a0, dashes
	syscall 
	
	#Ask the user if they want to enter a new score
	j reTry

grade_D:
	#Prints the grade D
	li $v0, 4
	la $a0, gradeD
	syscall

	#Prints the dashes
	li $v0, 4
	la $a0, dashes
	syscall 
	
	#Ask the user if they want to enter a new score
	j reTry

grade_F:
	#Prints the grade F
	li $v0, 4
	la $a0, gradeF
	syscall
	
	#Prints the dashes
	li $v0, 4
	la $a0, dashes
	syscall 
	
	#Ask the user if they want to enter a new score
	j reTry
	
exit:
	#Tell the user the program will now exit
	li $v0, 4
	la $a0, exitPrompt
	syscall
	
	#Exit the program
	li $v0, 10
	syscall
