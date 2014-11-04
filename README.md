mips-snake
==========
Charles Smith


bugs:
cirular buffer not working right, snake not always drawn in right place, tail not cleared
if there is a wall in the way, it eats the wall
DOES NOT KEEP TRACK OF TIME
does not step in a uniform time
does not reaper on other side of screen when going off screen
top left LED [0,0] gets cleared
snake collision not working right
initialize is slow






MAIN:
calls initialize
calls play
calls endgame
calls exit






INITIALIZE:
calls placefrogs
calls playSound
calls placewalls
calls playSound
calls placesnake

PLACEFROGS:
creates 2 random numbers [0,63]
places a green LED there
recursive calls itself 32 times

PLACEWALLS:
reads the .data section for each row
places a red LED where ever a * is and leaves ' ' untouched
does so by traversing each line and taking the offset as the x co-ordinate and the row in the .data as the y
This will place walls over frogs
#this function could have been made a lot beter by not having 64 helper functions (1 for each row) and just used offsets better, but the Idea came after I was mostly done, and It's just ineffiecnt in line count, has only a small inpact of performance

PLAYSOUND:
uses syscalls to play note 69 (A) on a brass instrument

PLACESNAKE:
adds each peice of snake (tail first) to the snake buffer, and places a yellow LED on the bored






PLAY:
$s0 holds the direction of the snake
$s1 holds the offset of the head in the snake buffer
$s2 holds the total length of the snake
calls checkforend
calls changeDir
calls checkFrog
calls checkwall
calls checksnake
calls snakeMove
calls playsound
calls itself

CHECKFOREND:
goes through every combination checking for at least 1 green

CHANGE DIR:
reads the memory for a changed direction
changes the direction if the direction isn't a 180 turn

CHECKFROG:
branches for the specific direction the snake is facing
adds the frog to the front of the snake as the head
adds the location to the memory, going back to the begining of the circular buffer if necassary
changes the LED colour 
 
CHECKWALL:
checks if there is a wall in the direction the snake is moving
if there is it checks to see if turning is a posiblity
if there is no where to go it ends the game

CHECKSNAKE:
looks to see if the head is trying to move into the snake, ends the game if a snake LED is adjacent to the head in the direction the snake is moving


SNAKEMOVE:
sets tail to blank
adds new address to cirular buffer
moves the buffer counter forward
sets the new address to yellow LED
