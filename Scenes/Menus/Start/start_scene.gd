extends Control

func _on_button_solo_pressed():
	Globals.current_scene = Globals.player_select_scene
	get_tree().change_scene_to_file(Globals.loading_scene)

func _on_button_multi_pressed():
	Globals.current_scene = Globals.multiplayer_select_scene
	get_tree().change_scene_to_file(Globals.loading_scene)
