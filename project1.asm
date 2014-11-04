.data
#space for snake buffer
#bored
#game over message
snake: .space 80
msg: .asciiz "your score is: "
row0: .asciiz  "****************************************************************"
row1: .asciiz  "*                                                            * *"
row2: .asciiz  "*                                                              *"
row3: .asciiz  "*                                                              *"
row4: .asciiz  "*                                                              *"
row5: .asciiz  "*                                                              *"
row6: .asciiz  "*                                                              *"
row7: .asciiz  "*                                        *****                 *"
row8: .asciiz  "*                                        *   *                 *"
row9: .asciiz  "*                                        *   *                 *"
row10: .asciiz "*                                                              *"
row11: .asciiz "*                                                              *"
row12: .asciiz "*                                                              *"
row13: .asciiz "*                                                              *"
row14: .asciiz "*                                                              *"
row15: .asciiz "*                                                              *"
row16: .asciiz "*                                      ********                *"
row17: .asciiz "*                                                              *"
row18: .asciiz "*                                                              *"
row19: .asciiz "*                                                              *"
row20: .asciiz "*                                                              *"
row21: .asciiz "*                                                              *"
row22: .asciiz "*                                                              *"
row23: .asciiz "*                                                              *"
row24: .asciiz "*                                                              *"
row25: .asciiz "*                                                              *"
row26: .asciiz "*                                                              *"
row27: .asciiz "*                                                              *"
row28: .asciiz "*                                                              *"
row29: .asciiz "*                                                              *"
row30: .asciiz "*                                                              *"
row31: .asciiz "*                                                              *"
row32: .asciiz "*                                                              *"
row33: .asciiz "*                                                              *"
row34: .asciiz "*                                                              *"
row35: .asciiz "*                                                              *"
row36: .asciiz "*                                                              *"
row37: .asciiz "*                                                              *"
row38: .asciiz "*                                                              *"
row39: .asciiz "*                                                              *"
row40: .asciiz "*                                                              *"
row41: .asciiz "*                                                              *"
row42: .asciiz "*                                                              *"
row43: .asciiz "*                                                              *"
row44: .asciiz "*                                                              *"
row45: .asciiz "*                                                              *"
row46: .asciiz "*                                                              *"
row47: .asciiz "*                                                              *"
row48: .asciiz "*                                                              *"
row49: .asciiz "*                                                              *"
row50: .asciiz "*                                                              *"
row51: .asciiz "*                                                              *"
row52: .asciiz "*                                                              *"
row53: .asciiz "*                                                              *"
row54: .asciiz "*                                                              *"
row55: .asciiz "*                                                              *"
row56: .asciiz "*                                                              *"
row57: .asciiz "*                                                              *"
row58: .asciiz "*                                                              *"
row59: .asciiz "*                                                              *"
row60: .asciiz "*                                                              *"
row61: .asciiz "*                                                              *"
row62: .asciiz "*                                                              *"
row63: .asciiz "****************************************************************"





.text

#$s0 direction; eg. 0 north 1 east 2 south 3 west
#$s1 offset of head
#$s2 length

start:
	jal initialize	#sets up the game board
	jal play	#playing the game (jump down to about line 1,405 to see this)
	#jal gameover	#end of the game
	j exit		# this kills the program.


exit:
	li $v0, 10
	syscall	#ends the program
	
	
	
playSound:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
	li $v0, 31
	li $a0, 69
	li $a1, 400
	li $a2, 32
	li $a3, 127
	syscall
	j return



initialize:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
	jal addfrogs
	jal playSound
	nop
	jal walls
	jal playSound
	jal makesnake
	jal playSound
	j return
	
#-------------------------make snake ----------------------------------
makesnake:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
	li $a0, 4		#$a0 is x
	li $a1, 31
	sb $a0, snake
	sb $a1, snake + 1
	li $a2, 2
	jal _setLED
	li $a0, 5		
	li $a1, 31
	sb $a0, snake + 2
	sb $a1, snake + 3
	jal _setLED
	li $a0, 6		
	li $a1, 31
	sb $a0, snake + 4
	sb $a1, snake + 5
	jal _setLED
	li $a0, 7		
	li $a1, 31
	sb $a0, snake + 6
	sb $a1, snake + 7
	jal _setLED
	li $a0, 8		
	li $a1, 31
	sb $a0, snake + 8
	sb $a1, snake + 9
	jal _setLED
	li $a0, 9		
	li $a1, 31
	sb $a0, snake + 10
	sb $a1, snake + 11
	jal _setLED
	li $a0, 10		
	li $a1, 31
	sb $a0, snake + 12
	sb $a1, snake + 13
	jal _setLED
	li $a0, 11		
	li $a1, 31
	sb $a0, snake + 14
	sb $a1, snake + 15
	jal _setLED
	li $s0, 1
	li $s1, 14
	li $s2, 8
	j return

#-----------------------------adding walls--------------------------------------------------
walls:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
	li $t4, 0		#y
	li $t5, 0		#x
	li $t6, 42		# 42 is ascii for *
	li $t7, 0		# value from string
	jal wrow0
	jal nextrow
	jal wrow1
	jal nextrow
	jal wrow2
	jal nextrow
	jal wrow3
	jal nextrow
	jal wrow4
	jal nextrow
	jal wrow5
	jal nextrow
	jal wrow6
	jal nextrow
	jal wrow7
	jal nextrow
	jal wrow8
	jal nextrow
	jal wrow9
	jal nextrow
	jal wrow10
	jal nextrow
	jal wrow11
	jal nextrow
	jal wrow12
	jal nextrow
	jal wrow13
	jal nextrow
	jal wrow14
	jal nextrow
	jal wrow15
	jal nextrow
	jal wrow16
	jal nextrow
	jal wrow17
	jal nextrow
	jal wrow18
	jal nextrow
	jal wrow19
	jal nextrow
	jal wrow20
	jal nextrow
	jal wrow21
	jal nextrow
	jal wrow22
	jal nextrow
	jal wrow23
	jal nextrow
	jal wrow24
	jal nextrow
	jal wrow25
	jal nextrow
	jal wrow26
	jal nextrow
	jal wrow27
	jal nextrow
	jal wrow28
	jal nextrow
	jal wrow29
	jal nextrow
	jal wrow30
	jal nextrow
	jal wrow31
	jal nextrow
	jal wrow32
	jal nextrow
	jal wrow33
	jal nextrow
	jal wrow34
	jal nextrow
	jal wrow35
	jal nextrow
	jal wrow36
	jal nextrow
	jal wrow37
	jal nextrow
	jal wrow38
	jal nextrow
	jal wrow39
	jal nextrow
	jal wrow40
	jal nextrow
	jal wrow41
	jal nextrow
	jal wrow42
	jal nextrow
	jal wrow43
	jal nextrow
	jal wrow44
	jal nextrow
	jal wrow45
	jal nextrow
	jal wrow46
	jal nextrow
	jal wrow47
	jal nextrow
	jal wrow48
	jal nextrow
	jal wrow49
	jal nextrow
	jal wrow50
	jal nextrow
	jal wrow51
	jal nextrow
	jal wrow52
	jal nextrow
	jal wrow53
	jal nextrow
	jal wrow54
	jal nextrow
	jal wrow55
	jal nextrow
	jal wrow56
	jal nextrow
	jal wrow57
	jal nextrow
	jal wrow58
	jal nextrow
	jal wrow59
	jal nextrow
	jal wrow60
	jal nextrow
	jal wrow61
	jal nextrow
	jal wrow62
	jal nextrow
	jal wrow63
	j return
	
nextrow:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
	addi $t4, $t4, 1
	li $t5,0
	j return
	
wrow0:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow0:
	lb $t7, row0($t5)
	bne $t7, $t6, skipw0
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw0:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow0
	j return


wrow1:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow1:
	lb $t7, row1($t5)
	bne $t7, $t6, skipw1
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw1:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow1
	j return


wrow2:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow2:
	lb $t7, row2($t5)
	bne $t7, $t6, skipw2
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw2:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow2
	j return


wrow3:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow3:
	lb $t7, row3($t5)
	bne $t7, $t6, skipw3
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw3:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow3
	j return


wrow4:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow4:
	lb $t7, row4($t5)
	bne $t7, $t6, skipw4
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw4:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow4
	j return


wrow5:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow5:
	lb $t7, row5($t5)
	bne $t7, $t6, skipw5
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw5:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow5
	j return


wrow6:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow6:
	lb $t7, row6($t5)
	bne $t7, $t6, skipw6
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw6:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow6
	j return


wrow7:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow7:
	lb $t7, row7($t5)
	bne $t7, $t6, skipw7
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw7:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow7
	j return


wrow8:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow8:
	lb $t7, row8($t5)
	bne $t7, $t6, skipw8
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw8:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow8
	j return


wrow9:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow9:
	lb $t7, row9($t5)
	bne $t7, $t6, skipw9
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw9:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow9
	j return


wrow10:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow10:
	lb $t7, row10($t5)
	bne $t7, $t6, skipw10
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw10:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow10
	j return


wrow11:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow11:
	lb $t7, row11($t5)
	bne $t7, $t6, skipw11
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw11:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow11
	j return


wrow12:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow12:
	lb $t7, row12($t5)
	bne $t7, $t6, skipw12
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw12:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow12
	j return


wrow13:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow13:
	lb $t7, row13($t5)
	bne $t7, $t6, skipw13
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw13:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow13
	j return


wrow14:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow14:
	lb $t7, row14($t5)
	bne $t7, $t6, skipw14
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw14:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow14
	j return


wrow15:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow15:
	lb $t7, row15($t5)
	bne $t7, $t6, skipw15
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw15:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow15
	j return


wrow16:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow16:
	lb $t7, row16($t5)
	bne $t7, $t6, skipw16
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw16:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow16
	j return


wrow17:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow17:
	lb $t7, row17($t5)
	bne $t7, $t6, skipw17
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw17:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow17
	j return


wrow18:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow18:
	lb $t7, row18($t5)
	bne $t7, $t6, skipw18
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw18:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow18
	j return


wrow19:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow19:
	lb $t7, row19($t5)
	bne $t7, $t6, skipw19
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw19:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow19
	j return


wrow20:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow20:
	lb $t7, row20($t5)
	bne $t7, $t6, skipw20
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw20:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow20
	j return


wrow21:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow21:
	lb $t7, row21($t5)
	bne $t7, $t6, skipw21
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw21:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow21
	j return


wrow22:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow22:
	lb $t7, row22($t5)
	bne $t7, $t6, skipw22
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw22:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow22
	j return


wrow23:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow23:
	lb $t7, row23($t5)
	bne $t7, $t6, skipw23
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw23:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow23
	j return


wrow24:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow24:
	lb $t7, row24($t5)
	bne $t7, $t6, skipw24
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw24:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow24
	j return


wrow25:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow25:
	lb $t7, row25($t5)
	bne $t7, $t6, skipw25
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw25:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow25
	j return


wrow26:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow26:
	lb $t7, row26($t5)
	bne $t7, $t6, skipw26
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw26:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow26
	j return


wrow27:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow27:
	lb $t7, row27($t5)
	bne $t7, $t6, skipw27
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw27:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow27
	j return



wrow28:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow28:
	lb $t7, row28($t5)
	bne $t7, $t6, skipw28
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw28:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow28
	j return



wrow29:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow29:
	lb $t7, row29($t5)
	bne $t7, $t6, skipw29
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw29:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow29
	j return



wrow30:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow30:
	lb $t7, row30($t5)
	bne $t7, $t6, skipw30
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw30:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow30
	j return


wrow31:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow31:
	lb $t7, row31($t5)
	bne $t7, $t6, skipw31
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw31:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow31
	j return


wrow32:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow32:
	lb $t7, row32($t5)
	bne $t7, $t6, skipw32
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw32:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow32
	j return


wrow33:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow33:
	lb $t7, row33($t5)
	bne $t7, $t6, skipw33
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw33:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow33
	j return


wrow34:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow34:
	lb $t7, row34($t5)
	bne $t7, $t6, skipw34
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw34:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow34
	j return


wrow35:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow35:
	lb $t7, row35($t5)
	bne $t7, $t6, skipw35
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw35:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow35
	j return


wrow36:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow36:
	lb $t7, row36($t5)
	bne $t7, $t6, skipw36
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw36:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow36
	j return


wrow37:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow37:
	lb $t7, row37($t5)
	bne $t7, $t6, skipw37
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw37:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow37
	j return


wrow38:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow38:
	lb $t7, row38($t5)
	bne $t7, $t6, skipw38
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw38:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow38
	j return


wrow39:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow39:
	lb $t7, row39($t5)
	bne $t7, $t6, skipw39
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw39:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow39
	j return


wrow40:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow40:
	lb $t7, row40($t5)
	bne $t7, $t6, skipw40
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw40:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow40
	j return


wrow41:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow41:
	lb $t7, row41($t5)
	bne $t7, $t6, skipw4
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw41:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow41
	j return


wrow42:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow42:
	lb $t7, row42($t5)
	bne $t7, $t6, skipw42
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw42:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow42
	j return


wrow43:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow43:
	lb $t7, row43($t5)
	bne $t7, $t6, skipw43
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw43:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow43
	j return


wrow44:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow44:
	lb $t7, row44($t5)
	bne $t7, $t6, skipw44
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw44:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow44
	j return


wrow45:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow45:
	lb $t7, row45($t5)
	bne $t7, $t6, skipw45
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw45:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow45
	j return


wrow46:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow46:
	lb $t7, row46($t5)
	bne $t7, $t6, skipw46
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw46:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow46
	j return


wrow47:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow47:
	lb $t7, row47($t5)
	bne $t7, $t6, skipw47
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw47:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow47
	j return


wrow48:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow48:
	lb $t7, row48($t5)
	bne $t7, $t6, skipw48
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw48:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow48
	j return


wrow49:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow49:
	lb $t7, row4($t5)
	bne $t7, $t6, skipw49
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw49:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow49
	j return


wrow50:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow50:
	lb $t7, row50($t5)
	bne $t7, $t6, skipw50
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw50:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow50
	j return


wrow51:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow51:
	lb $t7, row51($t5)
	bne $t7, $t6, skipw51
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw51:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow51
	j return


wrow52:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow52:
	lb $t7, row52($t5)
	bne $t7, $t6, skipw52
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw52:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow52
	j return


wrow53:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow53:
	lb $t7, row53($t5)
	bne $t7, $t6, skipw53
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw53:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow53
	j return


wrow54:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow54:
	lb $t7, row54($t5)
	bne $t7, $t6, skipw54
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw54:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow54
	j return


wrow55:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow55:
	lb $t7, row55($t5)
	bne $t7, $t6, skipw55
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw55:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow55
	j return


wrow56:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow56:
	lb $t7, row56($t5)
	bne $t7, $t6, skipw56
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw56:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow56
	j return


wrow57:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow57:
	lb $t7, row57($t5)
	bne $t7, $t6, skipw57
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw57:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow57
	j return


wrow58:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow58:
	lb $t7, row58($t5)
	bne $t7, $t6, skipw58
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw58:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow58
	j return


wrow59:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow59:
	lb $t7, row59($t5)
	bne $t7, $t6, skipw59
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw59:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow59
	j return


wrow60:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow60:
	lb $t7, row60($t5)
	bne $t7, $t6, skipw60
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw60:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow60
	j return


wrow61:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow61:
	lb $t7, row61($t5)
	bne $t7, $t6, skipw61
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw61:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow61
	j return


wrow62:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow62:
	lb $t7, row62($t5)
	bne $t7, $t6, skipw62
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw62:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow62
	j return


wrow63:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
loopwrow63:
	lb $t7, row63($t5)
	bne $t7, $t6, skipw63
	move $a0, $t5
	move $a1, $t4
	jal wall
skipw63:
	addi $t5, $t5, 1
	bne $t5, 64, loopwrow63
	j return




#-------- keep going till 63 --------
	
	

	
wall:	#placed at $a0, $a1
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
	li $a2, 1
	jal _setLED
	j return

#-----------------------adding frogs---------------------------------------------------

addfrogs:	#$t0 ~ $t4 are not safe here; adds all the frogs; this also uses
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
	li $t4, 0
addfrogsl:
	beq $t4, 32, return
	addi $t4, $t4, 1
	jal addfrog
	j addfrogsl
addfrog:	#adds 1 randomly placed frog
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
	li $v0, 42
	li $a1, 63
	syscall
	move $t0, $a0
	syscall
	move $t1, $a0
	move $a0, $t0
	move $a1, $t1
	li $a2, 3
	jal _setLED
	j return

	
return:			
	lw $ra, ($sp)
	addi $sp, $sp, 4
	jr $ra		#back to where we were before





#------------------------stuff I didn't write---------------------------------------------------

# _setLED and _getLED functions for Keypad and LED Display Simulator (64x64)
#
# These functions may be used in your CS/CoE 0447 Project 1.
# They provide a convenient interface to the Keypad and LED Display Simulator
# extension (64x64) in MARS 4.4-Pitt.1.  For arguments and return values,
# read the comments above each; call them like any other MIPS function.
#
# If you're really interested, look through the code to show yourself
# how it works, or even practice writing these yourself!  You know
# all the pieces; try fitting them together!


	# void _setLED(int x, int y, int color)
	#   sets the LED at (x,y) to color
	#   color: 0=off, 1=red, 2=yellow, 3=green
	#
	# arguments: $a0 is x, $a1 is y, $a2 is color
	# trashes:   $t0-$t3
	# returns:   none
	#
_setLED:
	# byte offset into display = y * 16 bytes + (x / 4)
	sll	$t0,$a1,4      # y * 16 bytes
	srl	$t1,$a0,2      # x / 4
	add	$t0,$t0,$t1    # byte offset into display
	li	$t2,0xffff0008 # base address of LED display
	add	$t0,$t2,$t0    # address of byte with the LED
	# now, compute led position in the byte and the mask for it
	andi	$t1,$a0,0x3    # remainder is led position in byte
	neg	$t1,$t1        # negate position for subtraction
	addi	$t1,$t1,3      # bit positions in reverse order
	sll	$t1,$t1,1      # led is 2 bits
	# compute two masks: one to clear field, one to set new color
	li	$t2,3		
	sllv	$t2,$t2,$t1
	not	$t2,$t2        # bit mask for clearing current color
	sllv	$t1,$a2,$t1    # bit mask for setting color
	# get current LED value, set the new field, store it back to LED
	lbu	$t3,0($t0)     # read current LED value	
	and	$t3,$t3,$t2    # clear the field for the color
	or	$t3,$t3,$t1    # set color field
	sb	$t3,0($t0)     # update display
	jr	$ra
	
	# int _getLED(int x, int y)
	#   returns the value of the LED at position (x,y)
	#
	#  arguments: $a0 holds x, $a1 holds y
	#  trashes:   $t0-$t2
	#  returns:   $v0 holds the value of the LED (0, 1, 2 or 3)
	#
_getLED:
	# byte offset into display = y * 16 bytes + (x / 4)
	sll  $t0,$a1,4      # y * 16 bytes
	srl  $t1,$a0,2      # x / 4
	add  $t0,$t0,$t1    # byte offset into display
	la   $t2,0xffff0008
	add  $t0,$t2,$t0    # address of byte with the LED
	# now, compute bit position in the byte and the mask for it
	andi $t1,$a0,0x3    # remainder is bit position in byte
	neg  $t1,$t1        # negate position for subtraction
	addi $t1,$t1,3      # bit positions in reverse order
    	sll  $t1,$t1,1      # led is 2 bits
	# load LED value, get the desired bit in the loaded byte
	lbu  $t2,0($t0)
	srlv $t2,$t2,$t1    # shift LED value to lsb position
	andi $v0,$t2,0x3    # mask off any remaining upper bits
	jr   $ra
	
	
	
	
	
	
	
	
#-------------------------- the game actually starts here --------------------------------------------
play:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)	
	jal checkforend		#checking for endgame
	bne $v0, 3, return
	jal changeDir		#changes the direction of the frog
	jal checkFrog		#checking for a frog in the next space, adds to snake if needed
	jal checkwall		#checks for the wall being in the way
	jal checksnake		#checks if the snake is in the way
	jal snakeMove		#moves the snake
	jal playSound
	li $v0, 32
	li $a0, 100
	syscall
	j play			#back to the top
#----------------------------------------------------------------------------------------------------
#this is the tricky part, making the snake move
snakeMove:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
	jal getTail
	li $a2, 0
	move $a0, $v0
	move $a1, $v1
	jal _setLED	#tail is now blank
	jal getHead
	beq $s0, 0, moveNorth
	beq $s0, 1, moveEast
	beq $s0, 2, moveSouth
	beq $s0, 3, moveWest
	
moveNorth:
	addi $s1, $s1, 2
	bgt $s1, 78, moveNorthLoop
moveNorthReturn:
	
	addi $v1, $v1, -1
	sb $v0, snake($s1)
	sb $v1, snake + 1 ($s1)
	li $a2, 2
	move $a0, $v0
	move $a1, $v1
	jal _setLED
	j return
moveNorthLoop:
	li $s1, 0
	j moveNorthReturn
	
moveSouth:
	addi $s1, $s1, 2
	bgt $s1, 78, moveSouthLoop
moveSouthReturn:

	addi $v1, $v1, 1
	sb $v0, snake($s1)
	sb $v1, snake + 1 ($s1)
	li $a2, 2
	move $a0, $v0
	move $a1, $v1
	jal _setLED
	j return
moveSouthLoop:
	li $s1, 0
	j moveSouthReturn
	
moveEast:
	addi $s1, $s1, 2
	bgt $s1, 78, moveEastLoop
moveEastReturn:

	addi $v0, $v0, 1
	sb $v0, snake($s1)
	sb $v1, snake + 1 ($s1)
	li $a2, 2
	move $a0, $v0
	move $a1, $v1
	jal _setLED
	j return
moveEastLoop:	#when the buffer needs to loop
	li $s1, 0
	j moveEastReturn
	
	
moveWest:
	addi $s1, $s1, 2
	bgt $s1, 78, moveWestLoop
moveWestReturn:
	addi $v0, $v0, -1
	sb $v0, snake($s1)
	sb $v1, snake + 1 ($s1)
	li $a2, 2
	move $a0, $v0
	move $a1, $v1
	jal _setLED
	j return
moveWestLoop:
	li $s1, 0
	j moveWestReturn
	
	
#----------------------------------------------------------------------------------------------------
#this will end the game if the snake tries to eat itself
checksnake:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
	jal getHead
	beq $s0, 0, checksnakeNorth
	beq $s0, 1, checksnakeEast
	beq $s0, 2, checksnakeSouth
	beq $s0, 3, checksnakeWest
	
checksnakeNorth:
	addi $a1, $v1, -1
	move $a0, $v0
	jal _getLED
	beq $v0, 2, endgame
	j return
	
checksnakeSouth:
	addi $a1, $v1, 1
	move $a0, $v0
	jal _getLED
	beq $v0, 2, endgame
	j return
	
checksnakeEast:
	addi $a0, $v0, 1
	move $a1, $v1
	jal _getLED
	beq $v0, 2, endgame
	j return
	
checksnakeWest:
	addi $a0, $v0, -1
	move $a1, $v1
	jal _getLED
	beq $v0, 2, endgame
	j return

	
#----------------------------------------------------------------------------------------------------	
checkforend:		#checks every square to see if there is a green.  returns 3 if there is at least 1; 0 if game is over
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
	li $a0, 0
	li $a1, 0
cfe_loop:
	jal _getLED
	beq $v0, 3, gnover
	addi $a0, $a0, 1
	beq $a0, 64, cfe_next
	j cfe_loop
cfe_next:
	addi $a1, $a1, 1
	beq $a1, 64, gover
	li $a0, 0
	j cfe_loop
gnover:		#game is not over
	j return
gover:		#game is over
	li $v0, 0
	j return
#-------------------------------------------------------------------	


checkFrog:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
	jal getHead
	move $a0, $v0
	move $a1, $v1
	beq $s0, 0, checkFrogNorth
	beq $s0, 1, checkFrogEast
	beq $s0, 2, checkFrogSouth
	beq $s0, 3, checkFrogWest
	
checkFrogNorth:
	addi $a1, $a1, -1
	jal _getLED
	beq $v0, 3, eat
	j return
	
checkFrogSouth:
	addi $a1, $a1, 1
	jal _getLED
	beq $v0, 3, eat
	j return
	
checkFrogEast:
	addi $a0, $a0, 1
	jal _getLED
	beq $v0, 3, eat
	j return
	
checkFrogWest:
	addi $a0, $a0, -1
	jal _getLED
	beq $v0, 3, eat
	j return
	
eat:		#sets the frog to be the new head
	beq $s1, 78, beginingEat 	#in this case, the head loops back to the front of the buffer
	addi $s1, $s1, 2
	sb $a0, snake($s1)
	sb $a1, snake + 1($s1)
	li $a2, 2
	jal _setLED
	addi $s2, $s2, 1
	j return
beginingEat:		#adds to the front of the buffer
	sb $a0, snake
	sb $a1, snake + 1
	li $a2, 2
	jal _setLED
	li $s1, 0
	addi $s2, $s2, 1
	j return
#------------------------------------------------------------------------------------------------------------
changeDir:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
	lw $t0, 0xFFFF0000
	bne $t0, 1, return 	#no input
	lw $t0, 0xFFFF0004
	beq $t0, 0xE0, changeNorth
	beq $t0, 0xE1, changeSouth
	beq $t0, 0xE2, changeWest
	beq $t0, 0xE3, changeEast
	beq $t0, 0x42, endgame
	j return		#shouldn't have gotten here, but returning in case it does to not fuck things up more
	
changeNorth:
	beq $s0, 0, return	#already going there
	beq $s0, 2, return	#can't turn around
	li $s0, 0
	j return		#set dir to north
	
changeSouth:
	beq $s0, 2, return	#already going there
	beq $s0, 0, return	#can't turn around
	li $s0, 2
	j return		#set dir to south
	
changeWest:
	beq $s0, 3, return	#already going there
	beq $s0, 1, return	#can't turn around
	li $s0, 3
	j return		#set dir to west
	
changeEast:
	beq $s0, 1, return	#already going there
	beq $s0, 3, return	#can't turn around
	li $s0, 1
	j return		#set dir to north
#-------------------------------------------------------------------------------------------------------------
#checking to see if a wall is in the way, changing the direction if possible or endinging the game if not
checkwall:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
	beq $s0, 0, checkNorth
	beq $s0, 1, checkEast
	beq $s0, 2, checkSouth
	beq $s0, 3, checkWest
	
checkNorth:
	jal getHead
	addi $a1, $v1, -1 
	move $a0, $v0
	jal _getLED
	bne $v0, 1, return
	#there is a wall to the north, let's check the east
	jal getHead
	addi $a0, $v0, 1
	move $a1, $v1
	jal _getLED
	bne $v0, 1, changeEast
	#nope, let's try west
	jal getHead
	addi $a0, $v0, -1
	move $a1, $v1
	jal _getLED
	bne $v0, 1, changeWest
	#looks like we're stuck
	j endgame

checkSouth:
	jal getHead
	addi $a1, $v1, 1 
	move $a0, $v0
	jal _getLED
	bne $v0, 1, return
	#there is a wall to the south, let's check the east
	jal getHead
	addi $a0, $v0, 1
	move $a1, $v1
	jal _getLED
	bne $v0, 1, changeEast
	#nope, let's try west
	jal getHead
	addi $a0, $v0, -1
	move $a1, $v1
	jal _getLED
	bne $v0, 1, changeWest
	#looks like we're stuck
	j endgame
	
checkEast:
	jal getHead
	addi $a0, $v0, 1 
	move $a1, $v1
	jal _getLED
	bne $v0, 1, return
	#there is a wall to the east, let's check the north
	jal getHead
	addi $a1, $v1, 1
	move $a0, $v0
	jal _getLED
	bne $v0, 1, changeNorth
	#nope, let's try south
	jal getHead
	addi $a1, $v1, -1
	move $a0, $v0
	jal _getLED
	bne $v0, 1, changeSouth
	#looks like we're stuck
	j endgame
	
checkWest:
	jal getHead
	addi $a0, $v0, -1 
	move $a1, $v1
	jal _getLED
	bne $v0, 1, return
	#there is a wall to the west, let's check the north
	jal getHead
	addi $a1, $v1, 1
	move $a0, $v0
	jal _getLED
	bne $v0, 1, changeNorth
	#nope, let's try south
	jal getHead
	addi $a1, $v1, -1
	move $a0, $v0
	jal _getLED
	bne $v0, 1, changeSouth
	#looks like we're stuck
	j endgame
	
	
#-------------------------------------------------------------------------------------------------------------
getHead:	#returns head of snake in $v0=x; $v1=y
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
	lb $v0, snake($s1)	#loads head into $v0
	lb $v1, snake + 1($s1)
	j return
	
getTail:
	addi $sp, $sp, -4 	#return is on the stack
	sw $ra, ($sp)
	
	mul $t0, $s2, 2
	sub $t0, $t0, 2
	sub $t1, $s1, $t0 	#subtracts the length * 2 from the offset
	bltz $t1, getTailloop	#loops back around if the subtraction is negative
getTailreturn:	
	lb $v0, snake($t1)
	lb $v1, snake + 1($t1)
	j return
getTailloop:
	addi $t1, $t1, 78
	j getTailreturn	

#--------------------------------------------------------------------------------------------------------------
endgame:
	li $v0, 56
	la $a0, msg
	subi $a1, $s2, 8
	syscall
	
	j exit
