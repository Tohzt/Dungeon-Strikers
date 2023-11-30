extends PlayerCharacter

@onready var sword_slash = preload("res://Scenes/Attacks/sword_slash.tscn")

func _ready():
	super()
	damage = 10

func basic_attack() -> void:
	is_attacking = true
	animate_to("melee")
	var inst_sword_slash = sword_slash.instantiate()
	inst_sword_slash.caster = self
	$Attacks.add_child(inst_sword_slash)
