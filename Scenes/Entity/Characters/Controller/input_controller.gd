extends Node

# TODO: Pass this info down on creation
@onready var Master: EntityClass = get_parent().get_parent()

var move: Vector2
var look: Vector2 = Vector2.RIGHT
var run: bool = false

func update_move() -> Vector2: return move
func update_look() -> Vector2: return look
func update_run()  -> bool:    return run

func _process(_delta):
	move = Vector2.ZERO
	move = Input.get_vector("LEFT", "RIGHT", "UP", "DOWN")
	
	var look_input = Input.get_vector("AIM_LEFT", "AIM_RIGHT", "AIM_UP", "AIM_DOWN")
	if Master.input_type == "Keyboard":
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		var mouse_pos:Vector2 = Master.get_local_mouse_position()
		look_input = (mouse_pos).normalized()
		
	if look_input.length():
		look = look_input
	elif move.length():
		look = move

func _unhandled_input(_event):
	run = false
	if Input.is_action_pressed("RUN"):
		run = true
	if Input.is_action_just_pressed("MELEE"):
		get_parent().get_parent().is_attacking = "melee"
	elif Input.is_action_just_pressed("RANGED"):
		get_parent().get_parent().is_attacking = "ranged"
