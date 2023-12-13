extends Node

var position: Vector2
var move: Vector2
var look: Vector2 = Vector2.RIGHT
var run: bool = false

func update_move() -> Vector2: return move
func update_look() -> Vector2: return look
func update_run()  -> bool:    return run

func _process(_delta):
	move = Vector2.ZERO
	position = get_parent().get_parent().global_position

	var look_input = position.direction_to(Globals.ball.global_position)
	look_input = look_input.normalized()
	
	if look_input.length():
		look = look_input
	elif move.length():
		look = move

#func _unhandled_input(_event):
	#run = false
	#if Input.is_action_pressed("RUN"):
		#run = true
	#if Input.is_action_just_pressed("ATTACK"):
		#get_parent().is_attacking = true
