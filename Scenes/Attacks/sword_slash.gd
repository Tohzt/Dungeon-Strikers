extends Node2D

@onready var anim = $AnimatedSprite2D
@onready var collision_polygon_2d = $Area2D/CollisionPolygon2D
@onready var area_2d = $Area2D

var caster: CharacterBody2D
var direction: Vector2
var speed: int = 10000

var damage := 0
var knockback := 0
var status := ""

func _ready():
	anim.play("sword_slash")
	rotation = caster.look_dir.angle() - PI/2
	direction = caster.look_dir
	damage = caster.damage
	knockback = caster.knockback
	status = caster.status

func _process(_delta):
	position = caster.global_position
	if !anim.is_playing():
		queue_free()

func _on_area_2d_body_entered(body):
	if body != caster:
		direction = (body.global_position - caster.global_position).normalized()
		if body.is_in_group("Ball") or body.is_in_group("Player"):
			# TODO: Try replacing with signals
			body.take_damage(damage, direction * knockback, status)
