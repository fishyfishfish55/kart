extends VehicleBody

export (float) var STEER_SPEED = .8
export (bool) var debug = true
export (Color) var body_color
export (Color) var trim_color
export (Color) var bumper_color
const STEER_LIMIT = 0.2

var steer_angle = 0
var steer_target = 0
export (float) var steer_damping = 0

export (int) var engine_force_value = 40

func _ready():
	update_colors()


func _physics_process(delta):
	var fwd_mps = transform.basis.xform_inv(linear_velocity).x
	
	steer_target = (Input.get_action_strength("turn_left") - Input.get_action_strength("turn_right")) * steer_damping
	steer_target *= STEER_LIMIT
	
	steering = steer_angle
	
	if Input.is_action_pressed("accelerate"):
		engine_force = engine_force_value
	else:
		engine_force = 0
	
	if Input.is_action_pressed("reverse"):
		engine_force = -engine_force_value
	if Input.is_action_pressed("brake"):
		brake = 1
	else:
		brake = 0
	if (linear_velocity.length() * 3.6) * .1 > 3 and (linear_velocity.length() * 3.6) < 9:
		gravity_scale = (linear_velocity.length() * 3.6)
	steer_angle = steer_target
	
	$WheelContainer/SteeringWheel.rotation = Vector3(steer_angle * 3, 0, 0)



func _process(delta):
	if Input.is_action_just_pressed("change_view"):
		if $CameraBase/Camera.current:
			$CameraBase/Camera.clear_current(false)
			$Camera2.make_current()
		else:
			$Camera2.clear_current(false)
			$CameraBase/Camera.make_current()
	$RPM.text = "RPM: " + str(round($Wheel1.get_rpm()))
	$MPH.text = "MPH: " + str(round(linear_velocity.length() * 3.6))
	if debug:
		update_colors()


func _integrate_forces(state):
	var xform = state.get_transform()
	if Input.is_action_just_pressed("spawn"):
		xform.origin += Vector3(191.772, 6.803, -343.158)
		set_angular_velocity(Vector3(0, 0, 0))
		set_linear_velocity(Vector3(0, 0, 0))
		xform = xform.looking_at(Vector3(175.126, 6.803, -325.358),\
		 Vector3.UP)
	if Input.is_action_just_pressed("reset"):
		xform.origin.y += 1
		xform = xform.looking_at(xform.origin, Vector3.UP)
		set_angular_velocity(Vector3(0, 0, 0))
		set_linear_velocity(Vector3(0, 0, 0))
	state.set_transform(xform)

func update_colors():
		$Body.get_surface_material(22).albedo_color = body_color
		$Body.get_surface_material(11).albedo_color = body_color
		$Body.get_surface_material(0).albedo_color = trim_color
		$Body.get_surface_material(2).albedo_color = trim_color
		$Body.get_surface_material(7).albedo_color = trim_color
		$Body.get_surface_material(10).albedo_color = trim_color
		$Body.get_surface_material(12).albedo_color = trim_color
		$Body.get_surface_material(19).albedo_color = trim_color
		$Body.get_surface_material(21).albedo_color = trim_color
		$Body.get_surface_material(28).albedo_color = trim_color
		$Body.get_surface_material(29).albedo_color = trim_color
		$Body.get_surface_material(30).albedo_color = trim_color
		$Body.get_surface_material(31).albedo_color = trim_color
		$Body.get_surface_material(35).albedo_color = trim_color
		$Body.get_surface_material(1).albedo_color = bumper_color
		$Body.get_surface_material(2).albedo_color = bumper_color
		$Body.get_surface_material(17).albedo_color = bumper_color
		$Body.get_surface_material(18).albedo_color = bumper_color
		$Body.get_surface_material(20).albedo_color = bumper_color
		$Body.get_surface_material(26).albedo_color = bumper_color
