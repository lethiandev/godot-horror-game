extends MeshInstance

var shadow_node: MeshInstance

func _ready():
	var self_shadow_setting = GeometryInstance.SHADOW_CASTING_SETTING_OFF
	set_cast_shadows_setting(self_shadow_setting)

func _enter_tree():
	shadow_node = MeshInstance.new()
	
	shadow_node.set_mesh(mesh)
	shadow_node.set_skeleton_path(skeleton)
	shadow_node.set_skin(skin)
	shadow_node.set_transform(transform)
	
	var node_name = name + "Shadow"
	shadow_node.set_name(node_name)
	
	var shadow_setting = GeometryInstance.SHADOW_CASTING_SETTING_SHADOWS_ONLY
	shadow_node.set_cast_shadows_setting(shadow_setting)
	
	get_parent().call_deferred("add_child", shadow_node)

func _exit_tree():
	if "queue_free" in shadow_node:
		shadow_node.queue_free()
