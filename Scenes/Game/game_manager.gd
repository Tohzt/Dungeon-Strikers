extends Node

@onready var pause_scene = preload("res://Scenes/Menus/Paused/pause_scene.tscn")
@onready var HUD: Node2D# = preload("res://Scenes/UI/hud.tscn")

const view := Vector2(5120, 3072)
var input_options = {0: "Keyboard", 1: "Controller"}
var input_type = 0

func _ready():
	randomize()
#	HUD = Globals.game.get_node("HUD")
	pass

func _process(_delta):
	pass

func update_ExperienceBar():
	if HUD:
		HUD.update_progress()

func _unhandled_input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		if Globals.game:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			var pause = pause_scene.instantiate()
			Globals.game.add_child(pause)
		else:
			print_debug("Game not set")
