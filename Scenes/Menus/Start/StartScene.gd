extends Control

const loading_scene = "res://Scenes/Menus/Loading/loading_scene.tscn"

func _ready():
	pass

func _process(_delta):
	pass

func _on_button_solo_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().change_scene_to_file(loading_scene)
