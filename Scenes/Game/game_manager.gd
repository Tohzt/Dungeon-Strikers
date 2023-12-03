extends Node

@onready var HUD: Node2D# = preload("res://Scenes/UI/hud.tscn")
var input_options = {0: "Keyboard", 1: "Controller"}
var input_type = 0

func _ready():
#	HUD = Globals.game.get_node("HUD")
	pass

func _process(_delta):
	pass

func update_ExperienceBar():
	if HUD:
		HUD.update_progress()

func _unhandled_input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		Globals.game.main_menu.show()
