extends Node

var move: Vector2
var run: bool = false

func update_move() -> Vector2: return move
func update_look() -> Vector2: return Vector2.ZERO
func update_run()  -> bool:    return run

func _process(_delta):
	move = Vector2.ZERO
	move = Input.get_vector("LEFT", "RIGHT", "UP", "DOWN")
	if move:
		update_move()
		update_run()

func _unhandled_input(_event):
	run = false
	if Input.is_action_pressed("RUN"):
		run = true
	if Input.is_action_just_pressed("ATTACK"):
		get_parent().is_attacking = true
