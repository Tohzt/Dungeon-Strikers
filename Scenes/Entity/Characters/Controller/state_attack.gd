# IDLE STATE
extends base_state

func init_state():
	Master.speed = 0
	match Master.is_attacking:
		"melee":
			Master.melee_attack()
		"ranged":
			Master.ranged_attack()

func process(_move, _look):
	if !Master.Anim.is_playing():
		Master.is_attacking = ""

func check_state() -> int:
	if !Master.is_attacking != "":
		return States.IDLE
	return States.NULL

func exit_state():
	pass
