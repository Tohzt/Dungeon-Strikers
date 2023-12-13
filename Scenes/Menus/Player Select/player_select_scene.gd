extends Control

@onready var button_knight = $MarginContainer/VBoxContainer/HBoxContainer/Button_Knight
@onready var button_play = $MarginContainer/VBoxContainer/HBoxContainer/Button_Play
@onready var button_mage = $MarginContainer/VBoxContainer/HBoxContainer/Button_Mage

@onready var knight = $MarginContainer/Knight
@onready var mage = $MarginContainer/Mage

var selection = 0

func _process(_delta):
	match selection:
		0:
			button_play.disabled = true
		1:
			button_mage.button_pressed = false
			button_play.disabled = false
		2:
			button_knight.button_pressed = false
			button_play.disabled = false

func _on_button_play_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Globals.current_scene = Globals.game_scene
	get_tree().change_scene_to_file(Globals.loading_scene)

func _on_button_knight_pressed():
	if selection != 1:
		Globals.selected_player = Globals.Knight
		selection = 1
		knight.material.set_shader_parameter("width", 3)
		knight.play("spin")
		mage.material.set_shader_parameter("width", 0)
		mage.pause()
		mage.frame = 0
	else:
		selection = 0
		knight.material.set_shader_parameter("width", 0)
		knight.pause()
		knight.frame = 0

func _on_button_mage_pressed():
	if selection != 2:
		Globals.selected_player = Globals.Mage
		selection = 2
		mage.material.set_shader_parameter("width", 4)
		mage.play("spin")
		knight.material.set_shader_parameter("width", 0)
		knight.pause()
		knight.frame = 0
		knight.material.set_shader_parameter("width", 0)
	else:
		selection = 0
		mage.material.set_shader_parameter("width", 0)
		mage.pause()
		mage.frame = 0


