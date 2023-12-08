# MOVE STATE
extends base_state

func init_state():
	Master.speed = Master.speed_max

func process(move, _look):
	#TODO: Add Coyote time to Attack
	Master.is_attacking = false
	if move.length() == 0: 
		Master.is_moving = false


func check_state() -> int:
	if !Master.is_moving:
		return States.IDLE
	if !Master.is_running:
		return States.WALK
	return States.NULL

func exit_state():
	pass
