extends CharacterBody2D
class_name EntityClass

@onready var Anim = $AnimatedSprite2D
@onready var StateController: Node = $StateController
@onready var AnimationController = $AnimationController
@onready var health_bar: ProgressBar = $ProgressBar
@onready var spawn_position := self.position

var InputController: Node
var input_type := "Keyboard"

var anims: Array = []

var is_moving: bool = false
var is_running: bool = false
var is_attacking: String = ""
var move_dir: Vector2 = Vector2.ZERO
var look_dir: Vector2 = Vector2.ZERO
var prev_dir: Vector2 = Vector2.ZERO
var incoming_force := Vector2.ZERO

var friction: float = 100.0
var speed: int
var speed_min: int
var speed_def: int
var speed_max: int
var speed_mod := 1.0

var atk_cd: int = 0
var atk_cd_min: int
var atk_cd_def: int
var atk_cd_max: int
var damage: int = 0
var knockback: int = 500
var status: String = ""

var max_iFrames: int = 100
var max_health: float = 100
var max_mana: float = 100
var max_stam: float = 100
var iFrames: int = 0
var health: int = int(max_health)
var mana: int = int(max_mana)
var stam: int = int(max_stam)

func _ready():
	if $InputController.get_child_count() == 0:
		var controller
		if self.is_in_group("Player"):
			controller = load("res://Scenes/Entity/Characters/Controller/input_controller.tscn").instantiate()
		else:
			controller = load("res://Scenes/Entity/Enemy/enemy_input_controller.tscn").instantiate()
		$InputController.add_child(controller)
	
	InputController = $InputController.get_child(0)
	StateController.init()

func _process(delta):
	health_bar.value = health / max_health * 100
	
	if move_dir.length() > 0:
		prev_dir = move_dir
	move_dir = InputController.update_move()
	look_dir = InputController.update_look()
	
	is_running = InputController.update_run()
	StateController.process(delta)
	#AnimationController.State = StateController.State
	
	var target_velocity: Vector2 = move_dir * speed *  speed_mod * delta
	incoming_force = incoming_force.move_toward(Vector2.ZERO, friction)
	velocity = target_velocity
	velocity += incoming_force

func animate_to(verb: String = "", dir: String = ""):
	var prev_anim = Anim.animation.rsplit("_")
	if verb == "":
		verb = prev_anim[0]
	if dir != "":
		prev_anim[-1] = dir
	var anim = verb + "_" + prev_anim[-1]
	Anim.play(anim)

func take_damage(dmg:int = 0, kb:Vector2 = Vector2.ZERO, _stat:String = ""):
	if iFrames == 0:
		health = max(health-dmg, 0)
		if health == 0:
			_respawn()
		incoming_force += kb

func _respawn():
	incoming_force = Vector2.ZERO
	velocity = Vector2.ZERO
	health = int(max_health)
	position = spawn_position
