class_name base_state
extends Node

var Master: CharacterBody2D
var Current
var States
var dir: String = ""

func init(master, states, current, new_state):
	Master = master
	Current = current
	States = states
	init_state()
	
	# TODO: Update Animations??
	match new_state:
		States.IDLE: 
			pass
		States.WALK: 
			pass
		States.RUN:
			pass
		States.HURT:
			pass
		States.ABILITY:
			pass
		States.ATTACK:
			pass

func _update_anim(verb: String):
	match Master.move_dir.normalized().round():
		Vector2.LEFT:   dir = "left"
		Vector2.RIGHT:  dir = "right"
		Vector2.UP:     dir = "up"
		Vector2.DOWN:   dir = "down"
		Vector2(1,1):   dir = "down-right"
		Vector2(-1,1):  dir = "down-left"
		Vector2(1,-1):  dir = "up-right"
		Vector2(-1,-1): dir = "up-left"
		_:
			dir = "down"
	Master.animate_to(verb, dir)

func init_state():
	print("init_state is not set")
func exit_state(): 
	print("exit_state is not set")
func update_master():
	print("update_state is not set")


