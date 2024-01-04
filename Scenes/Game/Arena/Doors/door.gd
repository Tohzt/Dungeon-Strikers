extends StaticBody2D
signal open_door(open_another: bool)
@onready var sprite = $AnimatedSprite2D

var is_open := false
var is_opening := false

func _ready():
	open_door.connect(_open_door)
	pass

func _process(_delta):
	if is_opening:
		if !sprite.is_playing():
			is_open = true
			is_opening = false
			set_collision_layer_value(1, false)

func _open_door(open_another := false):
	if open_another:
		var _dist_to_door = 1000
		var _door: StaticBody2D
		for door in get_tree().get_nodes_in_group("Door"):
			var dist = global_position.distance_to(door.global_position)
			if door != self and dist < _dist_to_door:
				_dist_to_door = dist
				_door = door
		_door.open_door.emit(false)
	else:
		print("Finished")
	if sprite.frame == 0:
		is_opening = true
		sprite.play()
