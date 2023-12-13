extends CharacterBody2D
class_name EntityClass

@onready var Anim = $AnimatedSprite2D
@onready var StateController: Node = $StateController

var Controller: Node

#var speed: int = 25000
var is_moving: bool = false
var is_running: bool = false
var is_attacking: bool = false
var move_dir: Vector2 = Vector2.ZERO
var look_dir: Vector2 = Vector2.ZERO
var prev_dir: Vector2 = Vector2.ZERO

var friction: float
var speed: int
var speed_min: int
var speed_def: int
var speed_max: int

var damage: int = 0

var max_heal: float = 100
var max_mana: float = 100
var max_stam: float = 100
var heal: int = int(max_heal)
var mana: int = int(max_mana)
var stam: int = int(max_stam)

func _ready():
	if $Controller.get_child_count() == 0:
		var controller = load("res://Scenes/Entity/Characters/Controller/input_controller.tscn").instantiate()
		$Controller.add_child(controller)
	
	Controller = $Controller.get_child(0)
	StateController.init()

func _process(delta):
	if move_dir.length() > 0:
		prev_dir = move_dir
	move_dir = Controller.update_move()
	look_dir = Controller.update_look()
	is_running = Controller.update_run()
	StateController.process(delta)

func animate_to(verb: String = "", dir: String = ""):
	var prev_anim = Anim.animation.rsplit("_")
	if verb == "":
		verb = prev_anim[0]
	if dir != "":
		prev_anim[-1] = dir
	var anim = verb + "_" + prev_anim[-1]
	Anim.play(anim)
