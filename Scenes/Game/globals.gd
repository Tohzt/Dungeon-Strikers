extends Node

@onready var game: Node2D# = get_tree().root.get_child(-1)
@onready var Mage: PackedScene = preload("res://Scenes/Entity/Characters/Mage/mage_scene.tscn")
@onready var Knight: PackedScene = preload("res://Scenes/Entity/Characters/Knight/knight_scene.tscn")

# Scenes
const loading_scene = "res://Scenes/Menus/Loading/loading_scene.tscn"
const start_scene = "res://Scenes/Menus/Start/start_scene.tscn"
const player_select_scene = "res://Scenes/Menus/Player Select/player_select_scene.tscn"
const multiplayer_select_scene = "res://Scenes/Menus/Local Multiplayer/multiplayer_select_scene.tscn"
const game_scene = "res://Scenes/Game/game_scene.tscn"

var current_scene: String
var selected_player: PackedScene

var ball: CharacterBody2D

enum BUMP {
	TOO_FAR,
	EARLY,
	LATE,
	PERFECT
}

var stats = {
	"score": 0,
	"bumps_late": 0,
	"bumps_perfect": 0,
	"bumps_early": 0,
	"time": 0.0,
}

func _ready() -> void:
	pass

#func reset_stats() -> void:
	#for key in stats.keys():
		#stats[key] = 0
