extends TileMap

enum ENTITY_TYPES {PLAYER, OBSTACLE}

var tile_size: = get_cell_size()
var half_tile_size: = tile_size / 2
var grid_size: = Vector2(cell_quadrant_size, cell_quadrant_size)

var grid = []

onready var Obstacle = preload("res://environment/obstacles/Obstacle.tscn")


func _ready() -> void:
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)

	var positions = []
	for n in range(5):
		var grid_pos = Vector2(randi() % int(grid_size.x), randi() % int(grid_size.y))
		if not grid_pos in positions:
			positions.append(grid_pos)

	for pos in positions:
		var new_obstacle = Obstacle.instance()
		new_obstacle.position = map_to_world(pos) + half_tile_size
		grid[pos.x][pos.y] = ENTITY_TYPES.OBSTACLE
		add_child(new_obstacle)


func is_cell_vacant():
	pass


func update_child_pos(child, new_pos, direction):
	pass
