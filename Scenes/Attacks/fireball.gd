extends CharacterBody2D

@onready var anim = $AnimatedSprite2D

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
	var collision = move_and_collide(velocity*delta)
	if collision:
		if collision.get_collider().is_in_group("Ball"):
			var ball = collision.get_collider()
			ball.hit_by(self)
		if collision.get_collider() != caster:
			queue_free()
