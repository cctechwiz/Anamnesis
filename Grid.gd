extends TileMap

var tile_size := get_cell_size()
var half_tile_size := tile_size / 2

var grid_size := Vector2(16, 16)
var grid = []

#onready var Obstacle = preload("")


func _ready():
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)

	var positions = []
	for n in range(5):
		var grid_pos = Vector2(randi() % int(grid_size.x) - 1, randi() % int(grid_size.y) - 1)
		if not grid_pos in positions:
			positions.append(grid_pos)

	#for position in positions:
		#var new_obstacle = Obstacle.instance()
		#add_child(new_obstacle)


func is_cell_vacant():
	pass


func update_child_pos(child, new_pos, direction):
	pass
