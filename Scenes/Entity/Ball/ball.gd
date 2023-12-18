extends SmackableClass

@onready var anim = $AnimatedSprite2D

func _ready() -> void:
	anim.play("Ball")
	friction = 0.01

func _process(delta: float) -> void:
	velocity = velocity.lerp(Vector2(0, 0), friction)
	super(delta)

func launch() -> void:
#	velocity = -global_transform.y * speed
	attached_to = null
