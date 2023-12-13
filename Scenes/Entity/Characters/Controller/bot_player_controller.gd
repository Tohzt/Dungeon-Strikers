extends Node

@onready var Master: CharacterBody2D = get_parent().get_parent()
@onready var ai_state = Master.get_node("StateController")

var target: Node2D
var position: Vector2
var move: Vector2 = Vector2.ZERO
var look: Vector2 = Vector2.RIGHT
var run: bool = false

func _ready():
	pass

func _process(delta):
	if !target:
		target = Globals.ball
	
	_update_state()
	
	var look_input = Master.global_position.direction_to(target.global_position).normalized()
	if look_input.length():
		look = look_input
	elif move.length():
		look = move

func update_move() -> Vector2: return move
func update_look() -> Vector2: return look
func update_run()  -> bool:    return run

func _update_state():
	#print(ai_state.State.name)
	match ai_state.State.name:
		"Idle":
			Master.is_moving = true
			pass
		"Walk":
			move = Master.global_position.direction_to(target.global_position).normalized()
			pass
		"Run":
			pass
		"Attack":
			pass
