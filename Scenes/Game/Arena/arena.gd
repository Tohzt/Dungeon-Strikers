extends Node2D

@onready var ball_spawn = $Spawns/BallSpawn

func _on_area_2d_body_entered(body):
	if body.position.x < GameManager.view.x/2:
		GameManager.add_goal("left")
	else: 
		GameManager.add_goal("right")
	Globals.game.reset_ball(body)
