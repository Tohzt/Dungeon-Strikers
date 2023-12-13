# TODO: Needs Gutting
extends Node

enum States {
	NULL,
	IDLE,
	WALK,
	RUN,
	DASH,
	ATTACK,
}
@onready var current = [
	null,
	$Idle,
	$Walk,
	$Run,
	$Dash,
	$Attack,
]

@onready var Master: Node2D = get_parent()

var State: base_state

func init() -> void:
	change_state(States.IDLE)

func change_state(new_state: int) -> void:
	State = current[new_state]
	if State:
		State.init(Master, States, current)

func process(delta):
	_update_animations()
	if State:
		State.process(Master.move_dir, Master.look_dir)
		var new_state = State.check_state()
		if new_state != States.NULL:
			change_state(new_state)
	

func _update_animations():
	var new_anim = ""
	match State.name:
		"Idle": 
			new_anim = "idle"
		"Walk": 
			new_anim = "walk"
		"Run":
			new_anim = "run"
		"Dash":
			pass
	if new_anim != "":
		_update_anim(new_anim)

func _update_anim(verb: String):
	var dir: String = ""
	match Master.look_dir.normalized().round():
		Vector2.LEFT:   dir = "left"
		Vector2.RIGHT:  dir = "right"
		Vector2.UP:     dir = "up"
		Vector2.DOWN:   dir = "down"
		Vector2(1,1):   dir = "down-right"
		Vector2(-1,1):  dir = "down-left"
		Vector2(1,-1):  dir = "up-right"
		Vector2(-1,-1): dir = "up-left"
		_:
			dir = "down"
	Master.animate_to(verb, dir)


