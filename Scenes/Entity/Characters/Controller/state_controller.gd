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
		State.init(Master, States, current, new_state)

func process(delta):
	if State:
		State.process(Master.move_dir, Master.look_dir, delta)
		var new_state = State.check_state()
		if new_state != States.NULL:
			change_state(new_state)

func _input(_event):
	pass
	#Master.velocity = Vector2.ZERO
	#input_dir = Input.get_vector("LEFT", "RIGHT", "UP", "DOWN").normalized()
	#input_target_dir = Input.get_vector("AIM_LEFT", "AIM_RIGHT", "AIM_UP", "AIM_DOWN").normalized()
	#
	#Master.speed = Master.walk_speed
	#var spd = speed * delta
	#var h_spd = Input.get_axis("LEFT", "RIGHT")
	#var v_spd = Input.get_axis("UP", "DOWN")
	#
	#if velocity != Vector2.ZERO:
		#prev_velocity = velocity
		#velocity = Vector2.ZERO
	#if Input.is_action_pressed("ui_select"):
		#pass#change_state(States.HURT)
	#if Input.is_action_just_pressed("ui_ability_l2"):
		#pass#change_state(States.ABILITY)
	#if Input.is_action_just_pressed("ui_attack_r2"):
		#Master.anim_play = false
		#change_state(States.ATTACK)





