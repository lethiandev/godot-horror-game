extends RayCast

func _process(p_delta) -> void:
	var n = cast_to.normalized()
	var distance = _get_ray_distance()
	
	_update_camera(n, distance)

func _get_ray_distance() -> float:
	var distance = cast_to.length()
	
	if is_colliding():
		var point = get_collision_point()
		var origin = global_transform.origin
		distance = origin.distance_to(point)
	
	return distance

func _update_camera(p_normal: Vector3, p_distance: float) -> void:
	var camera_node = get_node("Camera")
	var camera_xform = camera_node.transform
	
	camera_xform.origin = p_normal * (p_distance - 0.15)
	camera_node.transform = camera_xform
