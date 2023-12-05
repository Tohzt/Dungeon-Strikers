# MOVE STATE
extends base_state

func init_state():
	_update_anim("walk")

func process(move, _look, delta):
	if move.length() == 0: 
		Master.is_moving = false
	else:
		_update_anim("walk")
		Master.velocity = move * Master.speed_def * delta

func check_state() -> int:
	if !Master.is_moving:
		return States.IDLE
	if Master.is_running:
		return States.RUN
	return States.NULL

func exit_state():
	pass
