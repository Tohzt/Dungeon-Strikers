extends EntityClass

@onready var sword_slash = preload("res://Scenes/Attacks/sword_slash.tscn")

func _ready():
	# Declare Entity Variables
	friction = 1.0
	speed_min = 10000
	speed_def = 20000
	speed_max = 50000
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
	StateController._update_anim("melee")
	var inst_sword_slash = sword_slash.instantiate()
	inst_sword_slash.caster = self
	$Attacks.add_child(inst_sword_slash)

func ranged_attack() -> void:
	pass
