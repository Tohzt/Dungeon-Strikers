extends Node

@onready var Master: EntityClass = get_parent().get_parent()
@onready var ai_state = Master.get_node("StateController")

@export var attack_type: String = "ranged"
var chase_dist: int = 500
var position: Vector2
var move: Vector2 = Vector2.ZERO
var look: Vector2 = Vector2.RIGHT
var run: bool = false

func _ready():
	pass

func _process(_delta):
	# TODO: This is jenky as fuuuck
	if Master.incoming_force:
		for pl in get_tree().get_nodes_in_group("Player"):
			if pl != Master:
				Master.target = pl
	Master.target_position = Master.global_position + Vector2.RIGHT * 100
	if Master.target:
		Master.target_position = Master.target.global_position
	
	_attack_cooldown()
	_update_state()
	
	var look_input = Master.global_position.direction_to(Master.target_position).normalized()
	if look_input.length():
		look = look_input
	elif move.length():
		look = move

func update_move() -> Vector2: return move
func update_look() -> Vector2: return look
func update_run()  -> bool:    return run

func _attack_cooldown():
	if Master.atk_cd > 0:
		Master.atk_cd-=1

func _update_state():
	match ai_state.State.name:
		"Idle":
			move = Vector2.LEFT
			pass
		"Walk":
			if Master.global_position.distance_to(Master.target_position) > chase_dist:
				run = true
			elif Master.atk_cd == 0:
				Master.atk_cd = Master.atk_cd_def
				Master.is_attacking = attack_type
				
			move = Master.global_position.direction_to(Master.target_position).normalized()
			pass
		"Run":
			if Master.global_position.distance_to(Master.target_position) < chase_dist:
				run = false
			move = Master.global_position.direction_to(Master.target_position).normalized()
			pass
		"Attack":
			pass
