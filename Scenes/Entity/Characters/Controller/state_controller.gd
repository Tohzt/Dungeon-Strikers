extends Node

enum States {
	NULL,
	IDLE,
	WALK,
	RUN,
	ATTACK,
	SLIDE,
	DASH,
}
@onready var current = [
	null,
	$Idle,
	$Walk,
	$Run,
	$Attack,
	$Slide,
	$Dash,
]

@onready var Master: EntityClass = get_parent()

var State: base_state

func init() -> void:
	change_state(States.IDLE)

func change_state(new_state: int) -> void:
	State = current[new_state]
	if State:
		Master.AnimationController._update_animations()
		State.init(Master, States, current)

func process(_delta):
	#print(Master)
	if State:
		if State.name != "Attack":
			Master.AnimationController._update_anim()
		State.process(Master.move_dir, Master.look_dir)
		var new_state = State.check_state()
		if new_state != States.NULL:
			change_state(new_state)

func _update_anim_controller():
	Master.AnimationController.State = State
