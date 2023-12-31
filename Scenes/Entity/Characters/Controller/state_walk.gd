# MOVE STATE
extends base_state

func init_state():
	Master.speed = Master.speed_def

func process(move, _look):
	if move.length() == 0: 
		Master.is_moving = false

func check_state() -> int:
	if !Master.is_moving:
		return States.IDLE
	if Master.is_running:
		return States.RUN
	if Master.is_attacking != "":
		return States.ATTACK
	if Master.incoming_force.length() > 0:
		return States.SLIDE
	return States.NULL

func exit_state():
	pass
