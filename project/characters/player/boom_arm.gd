extends RayCast

func _process(p_delta) -> void:
	var n = cast_to.normalized()
	var distance = cast_to.length()
	
	if is_colliding():
		var point = get_collision_point()
		var origin = global_transform.origin
		distance = origin.distance_to(point)
	
	var camera_xform = $Camera.transform
	camera_xform.origin = n * (distance - 0.3)
	
	$Camera.transform = camera_xform
