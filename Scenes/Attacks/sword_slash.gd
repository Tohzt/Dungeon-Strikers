extends CharacterBody2D

@onready var anim = $AnimatedSprite2D

var direction: Vector2
var speed: int = 100
var caster: CharacterBody2D
var damage = 0

func _ready():
	anim.play("sword_slash")
	rotation = caster.prev_velocity.angle() - PI/2
	direction = caster.prev_velocity
	damage = caster.damage

func _process(_delta):
	var collision = move_and_collide(velocity)
	if collision:
		if collision.get_collider().is_in_group("Ball"):
			var ball = collision.get_collider()
			direction = (collision.get_collider().global_position - caster.global_position).normalized()
			ball.hit_by(self, direction * 2000)
			
	if !anim.is_playing():
		queue_free()
