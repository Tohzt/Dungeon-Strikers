extends CharacterBody2D

@onready var loot_preload = preload("res://Scenes/Loot/Exp.tscn")
@export var bump_timing_scene: PackedScene = preload("res://Scenes/Effects/Bump/bump_timing.tscn")
@export var speed: float = 100.0
@export var accel: float = 200.0
@export var deccel: float = 100.0
@export var max_normal_angle: float = 15.0
@export var max_speed: float = 1600.0
@export var steering_max_speed: float = 600.0
@export var steer_force = 110.0
@export var steer_speed = 300.0
@onready var health_bar = $Control/MarginContainer/HealthBar

var max_hp = 100
var hp = max_hp
var is_idle:bool = true
var friction = 0.01
var wander_speed = 120
var wander_timer = 0
var wander_interval = 0 

var acceleration: Vector2 = Vector2.ZERO
var attached_to = null
var hit_count: int = 0
var frame_count: int = 0
var no_collision_frame: int = 4
var attracted: bool = false
var attracted_to = null
var frames_since_paddle_collison: int = 0
var max_bump_distance: float = 40.0
var boost_factor: float = 1.0
var boost_factor_perfect: float = 1.3
var boost_factor_late_early: float = 1.15

@onready var anim = $AnimatedSprite2D

func _ready() -> void:
	health_bar.visible = false
	randomize()

func _physics_process(delta: float) -> void:
	frames_since_paddle_collison += 1
	
	if is_idle:
		_wander(delta)
		anim.play("Move")
	else:
		anim.play("Idle")
		velocity = velocity.lerp(Vector2(0, 0), friction)
		if velocity.length() < 200:
			is_idle = true
	
	if attached_to:
		global_position = attached_to.global_position
		return
		
	if attracted:
		var steer = Vector2.ZERO
		var desired = (attracted_to - position).normalized() * steer_speed
		steer = (desired - velocity).normalized() * steer_force
		acceleration += steer
		velocity += acceleration * delta
		velocity = velocity.limit_length(steering_max_speed)
#		rotation = velocity.angle()
	
	# Reset every frame to make sure we only attract
	# when pressing the button
	attracted = false
#	var velocity_before_collision = velocity
	var collision = move_and_collide(velocity * delta)
	if not collision: return
	
	var normal = collision.get_normal()

	# Update the normal with the paddle's velocity if we collide with attack
	if collision.get_collider().is_in_group("Attack"):
		frames_since_paddle_collison = 0
		
		normal = Vector2(sign(normal.x), 0)
		var normal_rotated = normal.rotated(-sign(normal.x)*deg_to_rad(20.0))
		velocity = normal_rotated * velocity.length()
		velocity *= boost_factor
		# Reset bump boost
		boost_factor = 1.0
	
	else:
		velocity = velocity.bounce(normal)
	
	if collision.get_collider().is_in_group("Player"):
		is_idle = false
	
	velocity = velocity.limit_length(max_speed)

func attract(global_pos) -> void:
	attracted = true
	attracted_to = global_pos
	
func spawn_bump_timing(type) -> void:
	var instance = bump_timing_scene.instantiate()
	instance.type = type
	get_parent().add_child(instance)
	instance.global_position = global_position
	
func bump_boost(who) -> void:
	var distance = who.global_position.distance_to(global_position)
	var contact_distance = distance - $CollisionShape2D.shape.radius - (who.thickness / 2.0)
	
	# If we're too far, we don't bump
	if contact_distance > max_bump_distance: 
		boost_factor = 1.0
		spawn_bump_timing(Globals.BUMP.TOO_FAR)
		return
	
	# We had a collision recently and we're now boosting: LATE
	if frames_since_paddle_collison > 5 and frames_since_paddle_collison < 20:
		boost_factor = boost_factor_late_early
		Globals.stats["bumps_late"] += 1
		spawn_bump_timing(Globals.BUMP.LATE)
	
	# Bump perfect
	elif frames_since_paddle_collison < 5:
		boost_factor = boost_factor_perfect
		Globals.stats["bumps_perfect"] += 1
		spawn_bump_timing(Globals.BUMP.PERFECT)
	
	# Bump early
	else:
		boost_factor = boost_factor_late_early
		Globals.stats["bumps_early"] += 1
		spawn_bump_timing(Globals.BUMP.EARLY)

func launch() -> void:
#	velocity = -global_transform.y * speed
	is_idle = true
	attached_to = null

func _wander(delta) -> void:
	# Update the wander timer
	wander_timer += delta

	# Check if it's time to change direction
	if wander_timer > wander_interval:
		# Change direction randomly
		randomize()
		var angle = randi_range(0, 360)
		var direction = Vector2(cos(deg_to_rad(angle)), sin(deg_to_rad(angle)))

		# Set the velocity based on the new direction and speed
		velocity = direction * wander_speed

		# Reset the wander timer
		wander_timer = 0
		wander_interval = randi_range(1,5)

func hit_by(obj, vel: Vector2 = Vector2.ZERO):
	health_bar.visible = true
	hp -= obj.damage
	health_bar.value = hp
	velocity = vel
	if vel.length() == 0:
		velocity = obj.velocity
	is_idle = false
	
	if hp <= 0:
		_die()

func _drop_loot() -> void:
	var loot = loot_preload.instantiate()
	loot.position = position
	loot.pop()
	Globals.game.add_child(loot)
	GameManager.update_ExperienceBar()

func _die() -> void:
	_drop_loot()
	queue_free()
