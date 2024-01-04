extends Node2D

@onready var area = $Area2D

var current_room := false
var room_complete := false
var num_of_mobs := []

func _ready():
	pass

func _process(_delta):
	if current_room:
		if not room_complete:
			if num_of_mobs.size() == 0:
				num_of_mobs = area.get_overlapping_bodies()
				print(num_of_mobs)
		pass

func _on_area_2d_body_exited(body):
	body.hide()
	if body.is_in_group("Player"):
		current_room = false
		body.overwrite_input = true
		Globals.game.start_timer.emit()

func _on_area_2d_body_entered(body):
	body.show()
	if body.is_in_group("Player"):
		current_room = true
		Globals.game.move_camera_towards(body)









#@onready var ball_spawn = $Spawns/BallSpawn

#func _on_area_2d_body_entered(body):
	#if body.position.x < GameManager.view.x/2:
		#GameManager.add_goal("left")
	#else: 
		#GameManager.add_goal("right")
	#Globals.game.reset_ball(body)
