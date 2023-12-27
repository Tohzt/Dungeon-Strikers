extends EntityClass

@onready var fireball = preload("res://Scenes/Attacks/fireball.tscn")
# TODO: Replace with Mages melee attack
@onready var sword_slash = preload("res://Scenes/Attacks/sword_slash.tscn")
@onready var direction_indicator: Sprite2D = $DirectionIndicator

func _ready():
	speed_min = 20000
	speed_def = 30000
	speed_max = 60000
	speed = speed_def
	
	atk_cd_min = 10
	atk_cd_def = 50
	atk_cd_max = 100
	
	damage = 5
	super()

func _process(delta):
	super(delta)
	move_and_slide()

func ranged_attack() -> void:
	AnimationController._update_anim("ranged")
	var inst_fireball = fireball.instantiate()
	inst_fireball.caster = self
	$Attacks.add_child(inst_fireball)

func melee_attack():
	# TODO: Replace with Mages melee attack
	AnimationController._update_anim("melee")
	var inst_sword_slash = sword_slash.instantiate()
	inst_sword_slash.caster = self
	$Attacks.add_child(inst_sword_slash)
	pass
