extends KinematicBody2D

onready var Grid = get_parent()

const UP := Vector2(0, -1)
const RIGHT_UP := Vector2(1, -1)
const RIGHT := Vector2(1, 0)
const RIGHT_DOWN := Vector2(1, 1)
const DOWN := Vector2(0, 1)
const LEFT_DOWN := Vector2(-1, 1)
const LEFT := Vector2(-1, 0)
const LEFT_UP := Vector2(-1, -1)


func _ready():
	update_look_direction(DOWN)


func _process(delta: float):
	var input_direction = get_input_direction()
	if not input_direction:
		return

	#print_direction_info(input_direction)
	update_look_direction(input_direction)


func get_input_direction():
	var left: bool = Input.is_action_pressed("ui_left")
	var right: bool = Input.is_action_pressed("ui_right")
	var up: bool = Input.is_action_pressed("ui_up")
	var down: bool = Input.is_action_pressed("ui_down")

	return Vector2(int(right) - int(left), int(down) - int(up))


func update_look_direction(direction):
	$Pivot/Sprite.rotation = direction.angle()
	$CollisionShape2D.rotation = direction.angle()


func print_direction_info(direction):
	match(direction):
		UP:
			print("up")
			print(direction.angle())
		RIGHT_UP:
			print("RIGHT_UP")
			print(direction.angle())
		RIGHT:
			print("right")
			print(direction.angle())
		RIGHT_DOWN:
			print("RIGHT_DOWN")
			print(direction.angle())
		DOWN:
			print("down")
			print(direction.angle())
		LEFT_DOWN:
			print("LEFT_DOWN")
			print(direction.angle())
		LEFT:
			print("left")
			print(direction.angle())
		LEFT_UP:
			print("LEFT_UP")
			print(direction.angle())
