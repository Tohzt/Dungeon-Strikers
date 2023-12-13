extends Node2D

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

@onready var player: CharacterBody2D
@onready var ball: CharacterBody2D = $Ball
@onready var arena: Node2D = $Arena

var health: int = 3
var energy: float = 0.0
var score_brick_destroyed: int = 200
var score_brick_touched: int = 50
var score: int = 0
var combo: int = 0
var bricks: Array
var bricks_to_destroy: Array
var time: float = 0
var started: bool = false

func _ready() -> void:
	# Spawn Selected Player
	player = Globals.selected_player.instantiate()
	$Players.add_child(player)
	
	Globals.game = self
	Globals.ball = ball
	randomize()
	ball.launch()
#	hide_combo()
#	ball.attached_to = ball_spawn
#	ball_spawn.ball_attached = ball
#	ball_spawn.ball = ball

func _process(delta) -> void:
	if not started: return
	time += delta

func reset_ball(entity):
	entity.position = arena.ball_spawn.global_position
	entity.velocity = Vector2.ZERO

func reset_and_attach_ball() -> void:
	ball.velocity = Vector2.ZERO
	ball.attached_to = player.launch_point
	player.ball_attached = ball
	player.game_over = false
	player.stage_clear = false

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