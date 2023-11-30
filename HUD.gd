extends Node2D

@onready var xp_bar: TextureRect = $P1/Experience/Experience

func _ready():
	xp_bar.texture.gradient.offsets[1] = 0

func update_progress() -> void:
	xp_bar.texture.gradient.offsets[1] += .1
