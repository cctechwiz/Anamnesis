extends TileMap

enum ENTITY_TYPES {EMPTY, PLAYER, OBSTACLE}

var tile_size: = get_cell_size()
var half_tile_size: = tile_size / 2
var grid_size: = Vector2(cell_quadrant_size, cell_quadrant_size)

var grid = []

onready var Obstacle = preload("res://environment/obstacles/Obstacle.tscn")


func _ready() -> void:
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(ENTITY_TYPES.EMPTY)

	var Player = get_node("Player")
	var player_start_pos = update_child_pos(Player)
	Player.position = player_start_pos

	var positions = []
	for n in range(5):
		var placed: = false
		while not placed:
			var grid_pos: = Vector2(randi() % int(grid_size.x), randi() % int(grid_size.y))
			if not grid[grid_pos.x][grid_pos.y]:
				if not grid_pos in positions:
					positions.append(grid_pos)
					placed = true

	for pos in positions:
		var new_obstacle = Obstacle.instance()
		new_obstacle.position = map_to_world(pos) + half_tile_size
		grid[pos.x][pos.y] = ENTITY_TYPES.OBSTACLE
		add_child(new_obstacle)


func is_cell_vacant(pos, direction=Vector2.ZERO):
	var grid_pos = world_to_map(pos) + direction

	# Check world boundaries
	if grid_pos.x < grid_size.x and grid_pos.x >= 0:
		if grid_pos.y < grid_size.y and grid_pos.y >= 0:
			# Return whether grid spaces is occupied or not
			return grid[grid_pos.x][grid_pos.y] == ENTITY_TYPES.EMPTY
	# Outside the grid
	return false


func update_child_pos(child_node, direction=Vector2.ZERO):
	var grid_pos = world_to_map(child_node.position)
	var new_grid_pos = grid_pos + direction

	grid[grid_pos.x][grid_pos.y] = ENTITY_TYPES.EMPTY
	grid[new_grid_pos.x][new_grid_pos.y] = child_node.type

	return map_to_world(new_grid_pos) + half_tile_size
