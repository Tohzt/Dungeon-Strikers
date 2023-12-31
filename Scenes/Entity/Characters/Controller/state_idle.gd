# IDLE STATE
extends base_state

func init_state():
	Master.speed = 0

func process(move, _look):
	if move: Master.is_moving = true

func check_state() -> int:
	if Master.is_moving:
		return States.WALK
	if Master.is_attacking != "":
		return States.ATTACK
	if Master.incoming_force.length() > 0:
		return States.SLIDE
	return States.NULL

func exit_state():
	pass
