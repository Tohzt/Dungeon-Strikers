extends Node2D

func _ready():
	var nums = [-50,50]
	var rand_num = nums[randi() % nums.size()]
	position += Vector2(rand_num, rand_num)

func pop():
	pass
