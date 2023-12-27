extends Node

@onready var Master: EntityClass = get_parent().get_parent()

var move: Vector2
var look: Vector2 = Vector2.RIGHT
var run: bool = false

func update_move() -> Vector2: return move
func update_look() -> Vector2: return look
func update_run()  -> bool:    return run

func _process(_delta):
	move = Vector2.ZERO
	var look_input = Input.get_vector("AIM_LEFT", "AIM_RIGHT", "AIM_UP", "AIM_DOWN")
	if Master.input_type == "Keyboard":
		move = Input.get_vector("LEFT_K", "RIGHT_K", "UP_K", "DOWN_K")
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		var mouse_pos:Vector2 = Master.get_local_mouse_position()
		look_input = (mouse_pos).normalized()
	
	elif Master.input_type == "Controller":
		move = Input.get_vector("LEFT_C", "RIGHT_C", "UP_C", "DOWN_C")
	
	if look_input.length():
		look = look_input
		_adjust_speed()
	elif move.length():
		look = move
		Master.speed_mod = 1.0
	if run:
		look = move
		Master.speed_mod = 1.0

func _adjust_speed():
	var look_angle = rad_to_deg(look.angle()) + 180
	var move_angle = rad_to_deg(move.angle()) + 180
	var delta_angle = abs(look_angle - move_angle)
	look_angle = 360 + look_angle
	if abs(look_angle - move_angle) < delta_angle:
		delta_angle = abs(look_angle - move_angle)
	Master.speed_mod = lerp(1.0, .5, delta_angle/180)
	

func _unhandled_input(_event):
	run = false
	if Master.input_type == "Keyboard": 
		if Input.is_action_pressed("RUN_K"):
			run = true
		if Input.is_action_just_pressed("MELEE_K"):
			get_parent().get_parent().is_attacking = "melee"
		elif Input.is_action_just_pressed("RANGED_K"):
			get_parent().get_parent().is_attacking = "ranged"
		
	elif Master.input_type == "Controller": 
		if Input.is_action_pressed("RUN_C"):
			run = true
		if Input.is_action_just_pressed("MELEE_C"):
			get_parent().get_parent().is_attacking = "melee"
		elif Input.is_action_just_pressed("RANGED_C"):
			get_parent().get_parent().is_attacking = "ranged"
			
