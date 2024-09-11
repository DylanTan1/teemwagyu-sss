extends Node

#signals from  day_night node will trigger this function
func currentGameState(currentState):
	
	if currentState == 0:
		print_debug("It's day time!")
	else :
		print_debug("It's night time!")
