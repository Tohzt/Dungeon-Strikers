extends Node2D

@onready var anim = $AnimatedSprite2D
@onready var collision_polygon_2d = $Area2D/CollisionPolygon2D
@onready var area_2d = $Area2D

var direction: Vector2
var speed: int = 100
var caster: CharacterBody2D
var damage = 0

func _ready():
	anim.play("sword_slash")
	rotation = caster.prev_dir.angle() - PI/2
	direction = caster.prev_dir
	damage = caster.damage

func _process(_delta):
	position = caster.global_position
	if !anim.is_playing():
		queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group("Ball"):
		direction = (body.global_position - caster.global_position).normalized()
		body.hit_by(self, direction * 2000)
