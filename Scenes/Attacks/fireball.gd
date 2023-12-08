extends Node2D

@onready var anim = $AnimatedSprite2D

var velocity: Vector2 = Vector2.ZERO
var direction: Vector2
var speed: int = 1000
var caster: CharacterBody2D
var damage = 0

func _ready():
	anim.play("fireball")
	direction = caster.target_direction
	position = caster.global_position
	rotation = caster.target_direction.angle() - PI/2
	velocity = direction * speed
	damage = caster.damage

func _physics_process(delta):
	position += velocity


func _on_area_2d_body_entered(body):
	if body.is_in_group("Ball"):
		direction = (body.global_position - caster.global_position).normalized()
		body.hit_by(self, direction * 2000)
		queue_free()
