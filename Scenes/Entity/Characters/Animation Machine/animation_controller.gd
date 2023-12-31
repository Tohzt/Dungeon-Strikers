extends Node
class_name AnimationClass

var Master: EntityClass

func _ready():
	Master = get_parent()

func _update_animations():
	var new_anim = ""
	match Master.StateController.State.name:
		"Idle": 
			new_anim = "idle"
		"Walk": 
			new_anim = "walk"
		"Attack":
			new_anim = Master.is_attacking
		"Run":
			new_anim = "run"
		"Slide":
			new_anim = "slide"
		"Dash":
			new_anim = "dash"
	
	if new_anim != "" and Master.anims.has(new_anim):
		_update_anim(new_anim)

func _update_anim(verb: String = ""):
	if verb == "":
		verb = Master.Anim.animation.rsplit("_")[0]
	
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
