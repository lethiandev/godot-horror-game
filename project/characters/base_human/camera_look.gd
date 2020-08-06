extends Camera

func _process(delta):
	if Input.is_key_pressed(KEY_O):
		rotate_x(delta)
	elif Input.is_key_pressed(KEY_L):
		rotate_x(-delta)
