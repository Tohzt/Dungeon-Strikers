extends Node

var move: Vector2
var look: Vector2 = Vector2.RIGHT
var run: bool = false

func update_move() -> Vector2: return move
func update_look() -> Vector2: return look
func update_run()  -> bool:    return run

func _process(_delta):
	move = Vector2.ZERO
	move = Input.get_vector("LEFT", "RIGHT", "UP", "DOWN")
	#if move:
		#update_move()
		#update_run()
	
	var look_input = Input.get_vector("AIM_LEFT", "AIM_RIGHT", "AIM_UP", "AIM_DOWN")
	if look_input.length():
		look = look_input
		#update_look()
	elif move.length():
		look = move
		#update_look()
	print(look)

func _unhandled_input(_event):
	run = false
	if Input.is_action_pressed("RUN"):
		run = true
	if Input.is_action_just_pressed("ATTACK"):
		get_parent().is_attacking = true
