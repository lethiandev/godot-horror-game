extends KinematicBody

func _init():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		_handle_mouse_motion(event)

func _handle_mouse_motion(p_event: InputEventMouseMotion):
	var motion = p_event.relative * 0.008
	
	_rotate_camera_y(-motion.x)
	_rotate_camera_x(-motion.y)
	
	var camera_xform = $CameraYaw/BoomArm/Camera.global_transform
	$PlayerSkin.look_target = -camera_xform.basis.z

func _rotate_camera_y(p_angle: float) -> void:
	$CameraYaw.rotate_y(p_angle)

func _rotate_camera_x(p_angle: float) -> void:
	var current_angle = $CameraYaw/BoomArm.rotation.x
	var next_angle = clamp(current_angle + p_angle, -PI * 0.35, PI * 0.35)
	
	$CameraYaw/BoomArm.rotation.x = next_angle
