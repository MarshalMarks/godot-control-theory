extends RigidBody2D

@export var disturbance_force = 50

func _integrate_forces(delta):
	var disturbance_direction = 0
	if(Input.is_action_pressed("move_right")):
		disturbance_direction += 1
	if(Input.is_action_pressed("move_left")):
		disturbance_direction -= 1
	
	apply_central_impulse(Vector2(disturbance_direction * disturbance_force, 0))
