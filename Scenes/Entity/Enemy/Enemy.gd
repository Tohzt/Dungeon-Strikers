extends SmackableClass

@onready var loot_preload = preload("res://Scenes/Loot/Exp.tscn")
#@onready var health_bar = $Control/MarginContainer/HealthBar

var max_hp = 100
var hp = max_hp
var wander_speed = 120
var wander_timer = 0
var wander_interval = 0 

@onready var anim = $AnimatedSprite2D

func _ready() -> void:
	anims = ["idle", "walk", "slide"]
	input_type = "AI"
	health_bar.visible = false
	speed_min = 5000
	speed_def = 10000
	speed_max = 20000
	speed = speed_def
	friction = 10
	
	atk_cd_min = 10
	atk_cd_def = 50
	atk_cd_max = 100

	damage = 10
	super()

func _process(delta: float) -> void:
	#if is_idle:
		#_wander(delta)
		#anim.play("move_down")
	#else:
		#anim.play("idle_down")
		#velocity = velocity.lerp(Vector2(0, 0), friction)
		#if velocity.length() < 200:
			#is_idle = true
	
	#move_and_slide()
	super(delta)

func _drop_loot() -> void:
	var loot = loot_preload.instantiate()
	loot.position = position
	loot.pop()
	#Globals.game.add_child(loot)
	GameManager.update_ExperienceBar()

func _die() -> void:
	_drop_loot()
	queue_free()

func _wander(delta) -> void:
	# Update the wander timer
	wander_timer += delta

	# Check if it's time to change direction
	if wander_timer > wander_interval:
		# Change direction randomly
		var angle = randi_range(0, 360)
		var direction = Vector2(cos(deg_to_rad(angle)), sin(deg_to_rad(angle)))

		# Set the velocity based on the new direction and speed
		velocity = direction * wander_speed

		# Reset the wander timer
		wander_timer = 0
		wander_interval = randi_range(1,5)

func hit_by(obj, _vel: Vector2 = Vector2.ZERO):
	health_bar.visible = true
	hp -= obj.damage
	health_bar.value = hp
	is_moving = false
	
	if hp <= 0:
		_die()

func melee_attack() -> void:
	is_attacking = ""
func ranged_attack() -> void:
	is_attacking = ""
