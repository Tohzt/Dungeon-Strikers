extends Control

const loading_scene = "res://Scenes/Loading/loading_scene.tscn"

func _ready():
	pass

func _process(_delta):
	pass

func _on_button_solo_pressed():
	get_tree().change_scene_to_file(loading_scene)
