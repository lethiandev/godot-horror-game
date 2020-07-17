extends Control

export(String) var source
var scene = null

func _ready():
	scene = load(source)
	if scene is PackedScene:
		_render_gltf(scene)

func _render_gltf(gltf: PackedScene):
	var inst = gltf.instance(PackedScene.GEN_EDIT_STATE_DISABLED)
	$Viewport.add_child(inst)
	
	var cam = Camera.new()
	inst.add_child(cam)
	cam.translation = Vector3(5, 5, 5)
	cam.current = true
	cam.look_at(Vector3(), Vector3(0, 1, 0))
	
	$Viewport.render_target_update_mode = Viewport.UPDATE_ONCE
	VisualServer.request_frame_drawn_callback(self, "_frame_updated", null)

func _frame_updated():
	$TextureRect.texture = $Viewport.get_texture()
