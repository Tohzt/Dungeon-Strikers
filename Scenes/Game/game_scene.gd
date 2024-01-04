extends Node2D

signal start_timer

@onready var debug = $Debug
@onready var timer = $Timer

@onready var scoreboard = $Camera2D/Scoreboard/MarginContainer/Score
@onready var arena: Node2D = $Rooms/Arena
@onready var camera : Camera2D = $Camera2D
@onready var camera_move := camera.position
var camera_speed = 50

@onready var player: CharacterBody2D
@onready var ball: SmackableClass #CharacterBody2D = $Ball

var health: int = 3
var energy: float = 0.0
var score_brick_destroyed: int = 200
var score_brick_touched: int = 50
var score: int = 0
var combo: int = 0
var bricks: Array
var bricks_to_destroy: Array

@onready var enemy: SmackableClass = $Enemies/Enemy

func _ready() -> void:
	start_timer.connect(_start_timer)
	if GameManager.local_multiplayer:
		var p1 = Globals.Knight.instantiate()
		p1.position = get_node("Spawns").get_node("P1_Spawn").position
		p1.input_type = "Keyboard"
		$Players.add_child(p1)
		var p2 = Globals.Mage.instantiate()
		p2.position = get_node("Spawns").get_node("P2_Spawn").position
		p2.input_type = "Controller"
		#var ai_controller = load("res://Scenes/Entity/Characters/Controller/bot_player_controller.tscn").instantiate()
		#p2.get_node("InputController").add_child(ai_controller)
		$Players.add_child(p2)
	else:
		player = Globals.selected_player.instantiate()
		$Players.add_child(player)
	
	Globals.game = self
	if ball:
		Globals.ball = ball
		ball.launch()

func _process(_delta):
	if debug.visible:
		var entity = $Enemies/Enemy
		$Debug/State.text = "HP: " + str(entity.health)
		#$Debug/MoveAngle.text = "Move Angle: : " + str(rad_to_deg(entity.move_dir.angle()))
		#$Debug/LookAngle.text = "Look Angle: : " + str(rad_to_deg(entity.look_dir.angle()))
		#$Debug/CameraPos.text = "camera_pos: " + str(camera.position)
		#$Debug/CameraMove.text = "camera_move: " + str(camera_move)
		#$Debug/PlayerPos.text = "player_pos: " + str(player.global_position)
		#$Debug/Speed_Mod.text = "Speed Mod: : " + str(player.speed_mod)
	
	if camera.position != camera_move:
		camera.position = camera.position.move_toward(camera_move, camera_speed)
	
	_update_score()

func _update_score():
	var _score = "{1} : {2}"
	var _s1 = str("%0*d" % [2, GameManager.score1])
	var _s2 = str("%0*d" % [2, GameManager.score2])
	scoreboard.text = _score.format({"1": _s1, "2": _s2})

func reset_ball(entity):
	entity.position = arena.ball_spawn.global_position
	entity.velocity = Vector2.ZERO

func move_camera_towards(body):
	var dir := Vector2.ZERO
	if body.global_position.x < camera.position.x:
		dir.x = -1
	elif body.global_position.x > camera.position.x + GameManager.view.x:
		dir.x = 1
	if body.global_position.y < camera.position.y:
		dir.y = -1
	elif body.global_position.y > camera.position.y + GameManager.view.y:
		dir.y = 1
	
	camera_move += dir * GameManager.view

func _start_timer():
	$Timer.start()
func _on_timer_timeout():
	$Players.get_child(0).overwrite_input = false







#region I dont know, some pong shit i think..

# From Template Project
#@export var brick_scene: PackedScene = preload("res://Scenes/Brick/brick.tscn")
#@export var block_energy: int = 10
#@export var energy_block_energy: int = 100
#@onready var energy_bar: Control = $CanvasLayer/EnergyBar
#@onready var health_bar: Control = $CanvasLayer/HealthBar
#@onready var score_ui = $CanvasLayer/Score
#@onready var spawn_pos_container: Node = $SpawnPos
#@onready var brick_container: Node = $Bricks
#@onready var combo_timer: Timer = $ComboTimer
#@onready var combo_lbl = $Combo

#var time: float = 0
#var started: bool = false
	
#func _process(delta) -> void:
	#if not started: return
	#time += delta


#func reset_and_attach_ball() -> void:
	#ball.velocity = Vector2.ZERO
	#ball.attached_to = player.launch_point
	#player.ball_attached = ball
	#player.game_over = false
	#player.stage_clear = false

# Template Functions
#func add_energy(value: float) -> void:
#	energy += value
#	energy = clamp(energy, 0, 100)
#	energy_bar.set_energy(energy)
#func remove_energy(value: float) -> void:
#	energy -= value
#	energy = clamp(energy, 0, 100)
#	energy_bar.set_energy(energy)
#func reset_energy() -> void:
#	energy = 0
#	energy_bar.set_energy(energy)
#func reset_health() -> void:
#	health = 3
#	health_bar.set_health(health)
#func reset_score() -> void:
#	score = 0
#	score_ui.set_score(score)
#func show_combo(combo: int) -> void:
#	combo_lbl.text = "COMBO " + str(combo)
#	combo_lbl.visible = true
#func hide_combo() -> void:
#	combo_lbl.visible = false
#func show_game_over() -> void:
#	var instance = game_over_scene.instantiate()
#	$CanvasLayer.add_child(instance)
#	instance.retry.connect(on_game_over_retry)
#func show_stage_clear() -> void:
#	var instance = stage_clear_scene.instantiate()
#	$CanvasLayer.add_child(instance)
#	instance.next.connect(on_stage_clear_next)
#func on_game_over_retry() -> void:
#	reset_and_attach_ball()
#	reset_health()
#	reset_energy()
#	reset_score()
#	time = 0.0
#	Globals.reset_stats()
#	remove_all_bricks()
#	layout_bricks()
#func on_stage_clear_next() -> void:
#	reset_and_attach_ball()
#	reset_health()
#	reset_energy()
#	reset_score()
#	time = 0.0
#	Globals.reset_stats()
#	remove_all_bricks()
#	layout_bricks()
#func _on_combo_timer_timeout():
#	combo = 0
#	hide_combo()
#func _on_player_start():
#	started = true
#func _on_DeathArea_body_entered(body: Node) -> void:
#	health_bar.set_health(health)
#	if not body.is_in_group("Ball"): return
#	health -= 1
#	health = int(clamp(health, 0, 3))
#
#	if health == 0:
#		player.game_over = true
#		show_game_over()
#		return
#
#	reset_and_attach_ball()

#endregion


