extends EntityClass

@onready var sword_slash = preload("res://Scenes/Attacks/sword_slash.tscn")

func _ready():
	# Declare Entity Variables
	friction = 1.0
	speed_min = 10000
	speed_def = 20000
	speed_max = 50000
	speed = speed_def
	
	damage = 10
	super()

func _process(delta):
	super(delta)
	move_and_slide()

func basic_attack() -> void:
	var inst_sword_slash = sword_slash.instantiate()
	inst_sword_slash.caster = self
	$Attacks.add_child(inst_sword_slash)
