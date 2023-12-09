extends EntityClass

@onready var fireball = preload("res://Scenes/Attacks/fireball.tscn")

func _ready():
	# Declare Entity Variables
	friction = 1.0
	speed_min = 10000
	speed_def = 20000
	speed_max = 50000
	speed = speed_def
	
	damage = 5
	super()

func _process(delta):
	super(delta)
	move_and_slide()

func basic_attack() -> void:
	StateController._update_anim("ranged")
	var inst_fireball = fireball.instantiate()
	inst_fireball.caster = self
	$Attacks.add_child(inst_fireball)
