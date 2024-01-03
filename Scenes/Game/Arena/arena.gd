extends Node2D

#@onready var ball_spawn = $Spawns/BallSpawn

#func _on_area_2d_body_entered(body):
	#if body.position.x < GameManager.view.x/2:
		#GameManager.add_goal("left")
	#else: 
		#GameManager.add_goal("right")
	#Globals.game.reset_ball(body)

func _on_area_2d_body_exited(body):
	body.overwrite_input = true
	body.hide()
	Globals.game.start_timer.emit()

func _on_area_2d_body_entered(body):
	body.show()
	Globals.game.move_camera_towards(body)

