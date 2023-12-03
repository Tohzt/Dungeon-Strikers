extends CharacterBody2D
class_name PlayerCharacter

@export var ai: bool = false

@onready var animation: AnimatedSprite2D = $AnimatedSprite2D

var is_attacking: bool = false
var prev_velocity: Vector2
var damage = 5

const SPEED = 25000.0
var force = 100000
var ball = null
var ball_attached = null
var target_direction: Vector2

func _ready():
	prev_velocity = Vector2.DOWN
	animation.play("idle_down")
	pass

func _process(delta):
	_update_animation()
	_update_target_direction()
	
	if ai:
		_ai_control()
		return
	
	var spd = SPEED * delta
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

func _update_animation():
	if !is_attacking:
		match velocity.normalized().round():
			Vector2.LEFT:
				animation.play("walk_left")
			Vector2.RIGHT:
				animation.play("walk_right")
			Vector2.UP:
				animation.play("walk_up")
			Vector2.DOWN:
				animation.play("walk_down")
			Vector2(1,1):
				animation.play("walk_down-right")
			Vector2(-1,1):
				animation.play("walk_down-left")
			Vector2(1,-1):
				animation.play("walk_up-right")
			Vector2(-1,-1):
				animation.play("walk_up-left")
			_:
				animate_to("idle")
	elif !animation.is_playing():
		animate_to("idle")
		is_attacking = false

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

func _unhandled_input(_event):
	if Input.is_action_just_released("Attack"):
		basic_attack()
