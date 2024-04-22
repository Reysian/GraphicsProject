extends CharacterBody3D


var speed = 1.5
var astar_grid: AStar3D
var maze
var player
var curr_point
var target
var player_point
var path = []

var enemy_ready = false

func _ready():
	#await get_tree().create_timer(10.0).timeout
	maze = get_node("../MazeNode")
	await(maze.setup_finished)
	player = get_node("../Player")
	astar_grid = maze.astar_grid
	position = astar_grid.get_point_position(maze.maze_size * maze.maze_size - 1)
	position.y += 0.5
	curr_point = astar_grid.get_closest_point(position)
	player_point = astar_grid.get_closest_point(player.transform.origin)
	path = astar_grid.get_id_path(curr_point, player_point)
	await get_tree().create_timer(6.0).timeout
	enemy_ready = true

func _physics_process(_delta):
	
	if enemy_ready:
		if path.size() > 1:
			target = astar_grid.get_point_position(path[1])
		else:
			target = player.transform.origin
			
		
		if abs(target.x - position.x) < 0.1 and abs(target.z - position.z) < 0.1:
			curr_point = astar_grid.get_closest_point(position)
			player_point = astar_grid.get_closest_point(player.transform.origin)
			path = astar_grid.get_id_path(curr_point, player_point)
		
		var direction = (target - position).normalized()
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		velocity.y = 0
		
		move_and_slide()

