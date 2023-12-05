extends CharacterBody2D
class_name EntityClass

@export_category("Input")
@export var InputController: Node

@onready var Anim = $AnimatedSprite2D
@onready var StateController = $StateController

#var speed: int = 25000
var is_moving: bool = false
var is_running: bool = false
var move_dir: Vector2 = Vector2(0,0)
var look_dir: Vector2 = Vector2(0,0)

var friction: float
var speed_min: int
var speed_def: int
var speed_max: int

var max_heal: float = 100
var max_mana: float = 100
var max_stam: float = 100
var heal: int = int(max_heal)
var mana: int = int(max_mana)
var stam: int = int(max_stam)

func _ready():
	StateController.init()

func _process(delta):
	move_dir = InputController.update_move()
	look_dir = InputController.update_look()
	is_running = InputController.update_run()
	StateController.process(delta)

func animate_to(verb: String = "", dir: String = ""):
	var anim_dir = Anim.animation.rsplit("_")
	if dir != "":
		anim_dir[-1] = dir
	var anim = verb + "_" + anim_dir[-1]
	Anim.play(anim)

#func basic_attack() -> void:
	#pass
	#is_attacking = true
	#animate_to("melee")
	#var inst_sword_slash = sword_slash.instantiate()
	#inst_sword_slash.caster = self
	#$Attacks.add_child(inst_sword_slash)
#func dash():
	#pass
