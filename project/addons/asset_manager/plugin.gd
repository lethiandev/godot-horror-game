tool
extends EditorPlugin

var dock: Control
var fm: FileDialog

func _enter_tree():
	dock = Panel.new()
	dock.name = "Asset Manager"
	add_control_to_dock(EditorPlugin.DOCK_SLOT_LEFT_BR, dock)
	
	fm = FileDialog.new()
	fm.mode = FileDialog.MODE_OPEN_DIR
	fm.access = FileDialog.ACCESS_FILESYSTEM
	get_editor_interface().get_base_control().add_child(fm)
	fm.popup_centered(Vector2(500, 400))

func _exit_tree():
	remove_control_from_docks(dock)
	dock.queue_free()
	fm.queue_free()
