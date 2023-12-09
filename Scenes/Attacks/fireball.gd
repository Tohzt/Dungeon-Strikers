extends Node2D

@onready var anim = $AnimatedSprite2D

var velocity: Vector2 = Vector2.ZERO
var direction: Vector2
var speed: int = 1000
var caster: CharacterBody2D
var damage = 0

func _ready():
	anim.play("fireball")
	direction = caster.move_dir
	position = caster.global_position
	rotation = caster.move_dir.angle() - PI/2
	velocity = direction * speed
	damage = caster.damage

func _process(delta):
	position += velocity * delta
	if anim.animation == "pop" and !anim.is_playing():
		queue_free()

func _pop():
	velocity = Vector2.ZERO
	anim.play("pop")

func _on_area_2d_body_entered(body):
	if body.is_in_group("Ball"):
		direction = (body.global_position - caster.global_position).normalized()
		body.hit_by(self, direction * 2000)
		_pop()

func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	_pop()
