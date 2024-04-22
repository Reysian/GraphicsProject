extends Node3D
signal game_win

var playerNear = false
var player
var accessed = false
@onready var fire_sound = $FirePlayer
@onready var win_sound = $WinPlayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("interact"):
		if playerNear and not accessed:
			accessed = true
			self.mesh = load("res://models/dresseropentest.obj")
			if self.get_node("Candle"):
				self.get_node("Candle").get_node("Candlelight").hide()
				fire_sound.play()
				player.get_node("OmniLight3D").base_range += 0.5
				player.get_node("OmniLight3D").base_range = clamp(player.get_node("OmniLight3D").base_range, 0, 2)
			elif randf() < 0.3:
				game_win.emit()
				print("you win")
				win_sound.play()
			else:
				print("you get nothing")
			
			player.get_node("CanvasLayer").get_node("Label").hide()
			
		

func _on_area_3d_body_entered(body):
	if not accessed:
		if body.get_name() == "Player":
			player = body
			playerNear = true
			player.get_node("CanvasLayer").get_node("Label").show()
		
		

func _on_area_3d_body_exited(body):
	if body.get_name() == "Player":
		playerNear = false
		player.get_node("CanvasLayer").get_node("Label").hide()
		self.mesh = load("res://models/dresser.obj")
