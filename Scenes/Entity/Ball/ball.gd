extends SmackableClass

@onready var anim = $AnimatedSprite2D

func _ready() -> void:
	anim.play("Ball")

func _process(delta: float) -> void:
	super(delta)

func launch() -> void:
#	velocity = -global_transform.y * speed
	attached_to = null
