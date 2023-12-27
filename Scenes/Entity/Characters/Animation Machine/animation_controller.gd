extends Node

var Master: CharacterBody2D
var State: base_state

func _ready():
	Master = get_parent()

func _process(_delta):
	#State = Master.get_node("StateController").State
	_update_animations()

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
