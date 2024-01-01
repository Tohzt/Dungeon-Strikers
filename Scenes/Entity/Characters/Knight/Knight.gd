extends EntityClass

# TODO: Replace with knights range attack
@onready var fireball = preload("res://Scenes/Attacks/fireball.tscn")
@onready var sword_slash = preload("res://Scenes/Attacks/sword_slash.tscn")
@onready var direction_indicator: Sprite2D = $DirectionIndicator

func _ready():
	anims = ["idle", "walk", "run", "melee"]
	
	speed_min = 10000
	speed_def = 15000
	speed_max = 30000
	speed = speed_def
	friction = 0.05
	
	atk_cd_min = 10
	atk_cd_def = 50
	atk_cd_max = 100

	damage = 0
	super()

func _process(delta):
	super(delta)
	move_and_slide()
	direction_indicator.rotation = look_dir.angle()

func melee_attack() -> void:
	#AnimationController._update_anim("melee")
	var inst_sword_slash = sword_slash.instantiate()
	inst_sword_slash.caster = self
	$Attacks.add_child(inst_sword_slash)

func ranged_attack() -> void:
	is_attacking = ""
	# TODO: Replace with knights range attack
	#AnimationController._update_anim("melee")
	var inst_fireball = fireball.instantiate()
	inst_fireball.caster = self
	$Attacks.add_child(inst_fireball)
