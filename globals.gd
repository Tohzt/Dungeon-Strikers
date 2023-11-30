extends Node

@onready var game = get_tree().root.get_child(-1)
@onready var Mage: PackedScene = preload("res://Scenes/Characters/mage.tscn")
@onready var Knight: PackedScene = preload("res://Scenes/Characters/knight.tscn")

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

func reset_stats() -> void:
	for key in stats.keys():
		stats[key] = 0
