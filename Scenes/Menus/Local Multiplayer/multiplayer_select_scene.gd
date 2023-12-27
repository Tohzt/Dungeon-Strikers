extends Control

func _on_button_play_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Globals.current_scene = Globals.game_scene
	GameManager.local_multiplayer = true
	get_tree().change_scene_to_file(Globals.loading_scene)
