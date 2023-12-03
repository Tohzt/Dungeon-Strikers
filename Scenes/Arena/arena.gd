extends Node2D

@onready var ball_spawn = $BallSpawn

func _on_area_2d_body_entered(body):
	Globals.game.reset_ball(body)
