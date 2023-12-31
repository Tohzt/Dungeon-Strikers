extends EntityClass
class_name SmackableClass

var attached_to = null
var attracted: bool = false
var attracted_to = null

#var friction = 0.05

func _process(delta):
	super(delta)
	
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		var collider = collision_info.get_collider()
		if collider.name == "TileMap":
			incoming_force = incoming_force.bounce(collision_info.get_normal())
	
	#if attached_to:
		#global_position = attached_to.global_position
		#return
		
	#if attracted:
		#var steer = Vector2.ZERO
		#var desired = (attracted_to - position).normalized() * steer_speed
		#steer = (desired - velocity).normalized() * steer_force
		#acceleration += steer
		#velocity += acceleration * delta
		#velocity = velocity.limit_length(steering_max_speed)
#		rotation = velocity.angle()
	
	# Reset every frame to make sure we only attract
	# when pressing the button
	#attracted = false
#	var velocity_before_collision = velocity

func attract(global_pos) -> void:
	attracted = true
	attracted_to = global_pos
