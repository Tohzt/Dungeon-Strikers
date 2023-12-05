# IDLE STATE
extends base_state

func init_state():
	Master.velocity = Vector2.ZERO
	Master.animate_to("idle")

func process(move, _look, _delta):
	if move: Master.is_moving = true

func check_state() -> int:
	if Master.is_moving:
		return States.WALK
	return States.NULL

func exit_state():
	pass
