extends Spatial

var look_target: Vector3 = Vector3.FORWARD

func _process(delta) -> void:
	_update_skeleton()

func _update_skeleton() -> void:
	var back_idx = $Armature/Skeleton.find_bone("back")
	var head_idx = $Armature/Skeleton.find_bone("head")
	
	_rotate_bone(back_idx, look_target, 0.32)
	_rotate_bone(head_idx, look_target, 0.35)

func _rotate_bone(p_bone: int, p_target: Vector3, p_factor: float) -> void:
	var xform = Transform().looking_at(p_target, Vector3.UP)
	var pose = $Armature/Skeleton.get_bone_pose(p_bone)
	
	$Armature/Skeleton.set_bone_pose(p_bone, pose.interpolate_with(xform, p_factor))
