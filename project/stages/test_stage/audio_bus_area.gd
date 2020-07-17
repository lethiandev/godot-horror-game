extends Area

var audio_effect: AudioEffectLowPassFilter
var cutoff_target = 2000

func _ready():
	connect("body_entered", self, "_body_entered")
	connect("body_exited", self, "_body_exited")
	
	audio_effect = AudioServer.get_bus_effect(2, 0)

func _process(delta):
	if audio_effect.cutoff_hz < cutoff_target:
		audio_effect.cutoff_hz += 200
	elif audio_effect.cutoff_hz > cutoff_target:
		audio_effect.cutoff_hz -= 200

func _body_entered(body: PhysicsBody):
	if body is KinematicBody:
		cutoff_target = 10500

func _body_exited(body: PhysicsBody):
	if body is KinematicBody:
		cutoff_target = 2000
