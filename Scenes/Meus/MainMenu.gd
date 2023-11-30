extends Control

@onready var game_scene = preload("res://game.tscn")
@onready var button_start = $MarginContainer/CenterContainer/HBoxContainer/VBoxContainer2/Button_Start
@onready var button_settings = $MarginContainer/CenterContainer/HBoxContainer/VBoxContainer2/Button_Settings


func _ready():
	pass

func _process(_delta):
	pass

func _on_button_solo_pressed():
	queue_free()
	if GameManager.menu_node.get_child_count():
		GameManager.menu_node.get_child(0).queue_free()
	GameManager.goto_next_level()
