extends CharacterBody2D
class_name PlayerCharacter

@export var ai: bool = false

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D

var damage = 5
var is_attacking: bool = false
var is_dashing: bool = false
var is_running: bool = false
var prev_velocity: Vector2
var dash_timer_cd: int = 100
var dash_timer: int = dash_timer_cd

var speed = 25000.0
var walk_speed = speed
var run_speed = speed * 2
var force = 100000
var ball = null
var ball_attached = null
var target_direction: Vector2

func _ready():
	prev_velocity = Vector2.DOWN
	animation.play("idle_down")
	pass

func _process(delta):
	_update_target_direction()
	
	if ai:
		_ai_control()
		return
		
	speed = walk_speed if !is_running else run_speed
	var spd = speed * delta
	var h_spd = Input.get_axis("LEFT", "RIGHT")
	var v_spd = Input.get_axis("UP", "DOWN")
	
	if velocity != Vector2.ZERO:
		prev_velocity = velocity
		velocity = Vector2.ZERO
	
	if !is_attacking:
		velocity.x = h_spd if h_spd else move_toward(velocity.x, 0, h_spd)
		velocity.y = v_spd if v_spd else move_toward(velocity.y, 0, v_spd)
		velocity = velocity.normalized() * spd

func _physics_process(delta):
	if move_and_slide():
		for i in get_slide_collision_count():
			var col = get_slide_collision(i)
			if col.get_collider() is RigidBody2D:
				col.get_collider().apply_force(col.get_normal() * -force*delta)

func animate_to(new_anim: String = "idle") -> void:
	var current_anim = animation.animation.rsplit("_")
	var anim = new_anim + "_" + current_anim[-1]
	animation.play(anim)

func _ai_control() -> void:
	if Globals.ball:
		velocity.y = Globals.ball.velocity.y

func _update_target_direction() -> void:
	var mouse_pos = get_global_mouse_position()
	target_direction = (mouse_pos - position).normalized()

func basic_attack(): pass
func dash(): pass

func _unhandled_input(_event):
	if Input.is_action_just_released("Attack"):
		basic_attack()
	if Input.is_action_pressed("RUN"):
		dash_timer -= 1
		is_running = true
	if Input.is_action_just_released("RUN"):
		is_running = false
		if dash_timer > 0:
			dash()
		dash_timer = dash_timer_cd
