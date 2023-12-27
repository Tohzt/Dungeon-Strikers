extends CanvasLayer

@onready var button_input: Button = $MarginContainer/CenterContainer/VBoxContainer2/Button_Input

const loading_scene = "res://Scenes/Menus/Loading/loading_scene.tscn"

func _ready():
	if get_parent().get_node("Players").get_child_count() != 1:
		button_input.disabled = true

func _process(_delta):
	pass

func _on_button_resume_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	queue_free()

func _on_button_quit_pressed():
	get_tree().quit()

func _on_button_restart_pressed():
	Globals.current_scene = Globals.player_select_scene
	get_tree().change_scene_to_file(Globals.loading_scene)


func _on_button_input_pressed():
	if button_input.text == "Input: KB":
		button_input.text = "Input: Con"
		get_parent().player.input_type = "Controller"
	else:
		button_input.text = "Input: KB"
		get_parent().player.input_type = "Keyboard"
	
