extends Spatial

var nav: Navigation
var path: PoolVector3Array;
var points = Array()

export(Mesh) var mesh

func _enter_tree():
	if get_parent() is Navigation:
		nav = get_parent()

func _ready():
	var xform = global_transform
	gen_next_path()

func _physics_process(delta):
	if path and path.size() > 0:
		move_towards()
	
	var space = get_world().direct_space_state
	var xform = global_transform
	var from = xform.origin + Vector3(0.0, 0.5, 0.0)
	var to = from - Vector3(0.0, 2.0, 0.0)
	
	var coll = space.intersect_ray(from, to)
	if not coll.empty():
		var pos = xform.origin
		var height = coll["position"]
		pos.y = height.y + 0.9
		global_transform.origin = pos
	
func move_towards():
	var p = path[0]
	var xform = global_transform
	var from = Vector3(xform.origin.x, 0.0, xform.origin.z)
	var to = Vector3(p.x, 0.0, p.z)
	
	if from.distance_to(to) < 0.4:
		path.remove(0)
	else:
		var n = to - from
		n = n.normalized()
		global_translate(n * 0.05)

func gen_next_path():
	var player = get_node("../../Player") as Spatial
	
	while true:
		var xform = global_transform
		var target = player.global_transform
		var from = xform.origin - Vector3(0, 0.5, 0)
		path = nav.get_simple_path(from, target.origin, true)
		_update_points()
		yield(get_tree().create_timer(0.5), "timeout")

func _update_points():
	while points.size() < path.size():
		var point = MeshInstance.new()
		point.mesh = mesh
		get_parent().call_deferred("add_child", point)
		points.push_back(point)
	while points.size() > path.size():
		var point = points.pop_back()
		point.queue_free()
	for i in range(points.size()):
		var p = path[i]
		points[i].translation = p
