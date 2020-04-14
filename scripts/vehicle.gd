extends VehicleBody

const STEER_SPEED = 1
const STEER_LIMIT = 0.4

var steer_angle = 0
var steer_target = 0

export (int) var engine_force_value = 40

func _integrate_forces(state):
	var fwd_mps = transform.basis.xform_inv(linear_velocity).x
	
	steer_target = Input.get_action_strength("turn_left") - Input.get_action_strength("turn_right")
	steer_target *= STEER_LIMIT
	
	if Input.is_action_pressed("accelerate"):
		engine_force = engine_force_value
	else:
		engine_force = 0
	
	if Input.is_action_pressed("reverse"):
		if (fwd_mps >= -1):
			engine_force = -engine_force_value
		else:
			brake = 1
	else:
		brake = 0.0
	
	if steer_target < steer_angle:
		steer_angle -= STEER_SPEED * get_process_delta_time()
		if steer_target > steer_angle:
			steer_angle = steer_target
	elif steer_target > steer_angle:
		steer_angle += STEER_SPEED * get_process_delta_time()
		if steer_target < steer_angle:
			steer_angle = steer_target
	
	steering = steer_angle
