extends MarginContainer

var maze_size
signal start_game(maze_size)

func _on_button_pressed():
	var maze_size = $VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/SpinBox.value
	print("Button pressed, maze size: ", maze_size)
	emit_signal("start_game", maze_size)
	print("Signal emitted")
	
func _on_button_3_pressed():
	get_tree().quit()

func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://scenes/Settings.tscn")
