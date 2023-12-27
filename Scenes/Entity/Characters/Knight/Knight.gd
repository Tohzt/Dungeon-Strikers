extends EntityClass

# TODO: Replace with knights range attack
@onready var fireball = preload("res://Scenes/Attacks/fireball.tscn")
@onready var sword_slash = preload("res://Scenes/Attacks/sword_slash.tscn")

func _ready():
	speed_min = 20000
	speed_def = 30000
	speed_max = 60000
	speed = speed_def
	
	atk_cd_min = 10
	atk_cd_def = 50
	atk_cd_max = 100

	damage = 10
	super()

func _process(delta):
	super(delta)
	move_and_slide()

func melee_attack() -> void:
	AnimationController._update_anim("melee")
	var inst_sword_slash = sword_slash.instantiate()
	inst_sword_slash.caster = self
	$Attacks.add_child(inst_sword_slash)

func ranged_attack() -> void:
	# TODO: Replace with knights range attack
	AnimationController._update_anim("melee")
	var inst_fireball = fireball.instantiate()
	inst_fireball.caster = self
	$Attacks.add_child(inst_fireball)
