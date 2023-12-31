extends Node2D

@onready var anim = $AnimatedSprite2D

var caster: CharacterBody2D
var velocity: Vector2 = Vector2.ZERO
var direction: Vector2
var speed: int = 1000

var damage = 0
var knockback := 0
var status := ""

func _ready():
	anim.play("fireball")
	direction = caster.look_dir
	position = caster.global_position
	rotation = caster.look_dir.angle() - PI/2
	velocity = direction * speed
	damage = caster.damage
	knockback = caster.knockback
	status = caster.status

func _process(delta):
	position += velocity * delta
	if anim.animation == "pop" and !anim.is_playing():
		queue_free()

func _pop():
	velocity = Vector2.ZERO
	anim.play("pop")

func _on_area_2d_body_entered(body):
	if body != caster:
		direction = (body.global_position - caster.global_position).normalized()
		if body.is_in_group("Ball") or body.is_in_group("Player"):
			# TODO: Try replacing with signals
			body.take_damage(damage, direction * knockback, status)
		_pop()

func _on_area_2d_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	if body != caster:
		_pop()
