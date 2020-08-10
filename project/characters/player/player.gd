extends KinematicBody

func _init():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		_handle_mouse_motion(event)

func _handle_mouse_motion(p_event: InputEventMouseMotion):
	var motion = p_event.relative * 0.008
	
	$Yaw.rotate_y(-motion.x)
	$Yaw/BoomArm.rotate_x(-motion.y)
