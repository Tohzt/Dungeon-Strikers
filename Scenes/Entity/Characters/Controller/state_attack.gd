# IDLE STATE
extends base_state

func init_state():
	Master.speed = 0
	Master.basic_attack()

func process(_move, _look):
	if !Master.Anim.is_playing():
		Master.is_attacking = false

func check_state() -> int:
	if !Master.is_attacking:
		return States.IDLE
	return States.NULL

func exit_state():
	pass
