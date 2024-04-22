extends Node3D

@onready var maze = $MazeNode
@onready var first_person_camera = $Player/Camera3D
@onready var menu = $Menu
@onready var top_down_camera = $TopDownCamera

var maze_size = 15
var astar_grid: AStar3D
var timer_countdown = 5.0
var is_counting_down = false

func _ready():
	show_menu()

func show_menu():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	menu.show()
	var result = menu.connect("start_game", Callable(self, "_on_menu_start_game"))
	print("Connect result: ", result)
	
func _on_menu_start_game(maze_size):
	print("Signal received with maze size: ", maze_size)
	maze_size = int(maze_size)
	start_game(maze_size)
	menu.hide()

func switch_to_top_down_view(maze_size):
	top_down_camera.current = true
	top_down_camera.get_node("DirectionalLight3D").visible = true
	var maze_center_x = maze_size / 2.0
	var maze_center_z = -maze_size / 2.0
	var camera_height = max(maze_size+5, 15)
	top_down_camera.global_transform.origin = Vector3(-5, camera_height, 5)
	top_down_camera.look_at(Vector3(maze_center_x, 0, maze_center_z), Vector3.UP)
	timer_countdown = 5.0
	is_counting_down = true

func switch_to_first_person():
	top_down_camera.current = false
	first_person_camera.current = true
	top_down_camera.get_node("DirectionalLight3D").visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	is_counting_down = false

func start_game(maze_size):
	maze.setup_maze(maze_size)
	switch_to_top_down_view(maze_size)
	
func _process(delta):
	if is_counting_down:
		timer_countdown -= delta
		if timer_countdown <= 0:
			switch_to_first_person()
	

