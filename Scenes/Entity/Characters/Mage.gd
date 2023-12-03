extends PlayerCharacter

@onready var fireball = preload("res://Scenes/Attacks/fireball.tscn")

func basic_attack() -> void:
	var inst_fireball = fireball.instantiate()
	inst_fireball.caster = self
	get_parent().add_child(inst_fireball)
