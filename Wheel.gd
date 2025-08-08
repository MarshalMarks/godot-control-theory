extends RigidBody2D

@export var rotation_torque = 3000
@export var player_controlled = true

var clamp = 400

func get_error(angle):
	return angle-90

func controller(angle, wheel_position, set_point):
	var error = get_error(angle)
	var output = 0
	output += error
	output += max(-clamp, min(clamp, (wheel_position.x-set_point)))/30
	return output

func _integrate_forces(delta):
	var rotation_direction = 0
	if player_controlled:
		if(Input.is_action_pressed("move_right")):
			rotation_direction += 1
		if(Input.is_action_pressed("move_left")):
			rotation_direction -= 1
	else:
		var weight = get_node("../Weight")
		var wheel = get_node(".")
		var direction = rad_to_deg((wheel.global_position - weight.global_position).angle())
		rotation_direction = max(-1, min(1, controller(direction, wheel.global_position, 600)))
		
	apply_torque_impulse(rotation_direction * rotation_torque)
