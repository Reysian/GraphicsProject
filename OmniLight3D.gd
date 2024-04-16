extends OmniLight3D

var timer = 0.0
@export var base_range = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = randf() * 0.1
	$"../CanvasLayer/ProgressBar".value = base_range

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta
	if timer >= 0.1: # Adjust the flicker speed
		timer = 0
		if (base_range > 0):
			base_range -= 0.0025
		elif (base_range < 0):
			base_range = 0
		omni_range = randf_range(base_range-0.2, base_range+0.2)
		omni_attenuation = randf_range(0.3, 0.5)
		$"../CanvasLayer/ProgressBar".value = base_range

