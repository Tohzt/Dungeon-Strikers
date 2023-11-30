extends CanvasLayer

@onready var button_start = $MarginContainer/CenterContainer/HBoxContainer/VBoxContainer2/Button_Start
@onready var single_player = $MarginContainer/CenterContainer/HBoxContainer/VBoxContainer2/HBoxContainer/Single_Player
@onready var multi_player = $MarginContainer/CenterContainer/HBoxContainer/VBoxContainer2/HBoxContainer/Multi_Player
@onready var button_settings = $MarginContainer/CenterContainer/HBoxContainer/VBoxContainer2/Button_Settings
@onready var spawn_p_1 = $"../Spawns/Spawn_P1"
@onready var spawn_p_2 = $"../Spawns/Spawn_P2"
@onready var spawn_p_3 = $"../Spawns/Spawn_P3"
@onready var spawn_p_4 = $"../Spawns/Spawn_P4"

func _ready():
	pass

func _process(_delta):
	pass
	
func _on_button_start_pressed():
	var ball = get_tree().get_first_node_in_group("Ball")
	ball.position = Globals.game.ball_spawn.position
	hide()

func _on_single_player_toggled(button_pressed):
	if button_pressed: 
		multi_player.button_pressed = false
		spawn_p_1.position.y = 0
		spawn_p_2.position.y = 0
		spawn_p_3.position.y = 0
		spawn_p_4.position.y = 0
	else: 
		multi_player.button_pressed = true

func _on_multi_player_toggled(button_pressed):
	if button_pressed: 
		single_player.button_pressed = false
		spawn_p_1.position.y = -20
		spawn_p_2.position.y = 20
		spawn_p_3.position.y = -20
		spawn_p_4.position.y = 20
	else: 
		single_player.button_pressed = true

func _clear_players() -> void:
	var players = get_tree().get_nodes_in_group("Player")
	for player in players:
		player.queue_free()

func _on_button_mage_pressed():
	_clear_players()
	var mage = Globals.Mage.instantiate()
	mage.position = spawn_p_1.global_position
	Globals.game.add_child(mage)

func _on_button_knight_pressed():
	_clear_players()
	var knight = Globals.Knight.instantiate()
	knight.position = spawn_p_2.global_position
	Globals.game.add_child(knight)
