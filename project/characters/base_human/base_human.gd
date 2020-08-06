extends Spatial

var motion_value = 0.0
var rotation_value = 0.0

func _ready():
	set_process_priority(1)

func _process(delta):
	var ticks = OS.get_ticks_msec() * 0.001
	
	if Input.is_action_pressed("move_forward"):
		motion_value += delta
	elif Input.is_action_pressed("move_backward"):
		motion_value -= delta
	
	if Input.is_action_pressed("strafe_right"):
		rotation_value -= delta * 2.0
	elif Input.is_action_pressed("strafe_left"):
		rotation_value += delta * 2.0
	
	motion_value = clamp(motion_value, 0.0, 2.0)
	rotation_value = clamp(rotation_value, -PI * 0.4, PI * 0.4)
	
	$AnimationTree["parameters/movement/blend_position"] = motion_value
	
	_update_bone("back", rotation_value * 0.45)
	_update_bone("head", rotation_value * 0.55)

func _update_bone(p_name, p_value):
	var bone_idx = $Armature/Skeleton.find_bone(p_name)
	var xform = $Armature/Skeleton.get_bone_pose(bone_idx)
	
	xform = xform.rotated(Vector3(0.0, 1.0, 0.0), p_value)
	$Armature/Skeleton.set_bone_pose(bone_idx, xform)
