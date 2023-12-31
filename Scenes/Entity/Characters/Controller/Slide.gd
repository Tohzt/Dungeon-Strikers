# Slide STATE
extends base_state

func init_state():
	Master.is_moving = false
	Master.is_attacking = ""
	Master.is_running = false

func process(_move, _look):
	Master.move_dir = Vector2.ZERO

func check_state() -> int:
	if Master.velocity == Vector2.ZERO:
		return States.IDLE
	return States.NULL

func exit_state():
	pass
