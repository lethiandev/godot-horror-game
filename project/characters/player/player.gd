extends KinematicBody

var linear_velocity = Vector3()

func _init():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		_handle_mouse_motion(event)

func _physics_process(delta):
	var xform = $Yaw.global_transform
	var max_angle = 0.872664626
	var motion = Vector3()
	var gravity = Vector3.DOWN
	
	if Input.is_action_pressed("move_forward"):
		motion += xform.basis.z
	if Input.is_action_pressed("move_backward"):
		motion -= xform.basis.z
	if Input.is_action_pressed("strafe_right"):
		motion -= xform.basis.x
	if Input.is_action_pressed("strafe_left"):
		motion += xform.basis.x
	
	linear_velocity.x = 0
	linear_velocity.z = 0
	linear_velocity += motion.normalized() * 5.0
	linear_velocity += gravity
	
	var blend = Vector2(motion.x, motion.z)
	$Yaw/PlayerSkin/AnimationTree["parameters/locomotion/blend_position"] = blend
	
	linear_velocity = move_and_slide_with_snap(
		linear_velocity, Vector3.DOWN * 0.2, Vector3.UP, true, 4, max_angle)

func _handle_mouse_motion(event: InputEventMouseMotion):
	var motion = event.relative * 0.008
	var rotate = Vector2()
	
	rotate.y = $Yaw.rotation.y - motion.x
	rotate.x = $Yaw/Camera.rotation.x - motion.y
	
	$Yaw.rotation.y = rotate.y
	$Yaw/Camera.rotation.x = clamp(rotate.x, -PI * 0.40, PI * 0.45)
