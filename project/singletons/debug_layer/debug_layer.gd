extends CanvasLayer

func _process(delta):
	_update_fps_label(delta)

func _update_fps_label(delta):
	var fps = Engine.get_frames_per_second()
	var ms = floor(delta * 1000.0)
	
	$FPSLabel.text = "FPS: %d (%dms)" % [fps, ms]
