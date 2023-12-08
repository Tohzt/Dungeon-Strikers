extends CharacterBody2D
class_name EntityClass

@export_category("Input")
@export var InputController: Node

@onready var Anim = $AnimatedSprite2D
@onready var StateController = $StateController
@onready var Attacks: Node2D = get_node("Attacks")

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
	StateController.init()

func _process(delta):
	if move_dir.length() > 0:
		prev_dir = move_dir
	move_dir = InputController.update_move()
	look_dir = InputController.update_look()
	is_running = InputController.update_run()
	StateController.process(delta)

func animate_to(verb: String = "", dir: String = ""):
	var prev_anim = Anim.animation.rsplit("_")
	if verb == "":
		verb = prev_anim[0]
	if dir != "":
		prev_anim[-1] = dir
	var anim = verb + "_" + prev_anim[-1]
	Anim.play(anim)
