extends KinematicBody2D
class_name Player

export(int) var speed: = 400

onready var Grid = get_parent()

const UP: = Vector2(0, -1)
const RIGHT_UP: = Vector2(1, -1)
const RIGHT: = Vector2(1, 0)
const RIGHT_DOWN: = Vector2(1, 1)
const DOWN: = Vector2(0, 1)
const LEFT_DOWN: = Vector2(-1, 1)
const LEFT: = Vector2(-1, 0)
const LEFT_UP: = Vector2(-1, -1)


func _ready() -> void:
	# The default look direction is RIGHT
	update_look_direction(DOWN)


func _process(delta: float) -> void:
	var input_direction: Vector2 = get_input_direction()
	if not input_direction:
		return

	#print_direction_info(input_direction)
	update_look_direction(input_direction)
	move_and_slide(input_direction.normalized() * speed)


func get_input_direction() -> Vector2:
	var left: bool = Input.is_action_pressed("ui_left")
	var right: bool = Input.is_action_pressed("ui_right")
	var up: bool = Input.is_action_pressed("ui_up")
	var down: bool = Input.is_action_pressed("ui_down")

	return Vector2(int(right) - int(left), int(down) - int(up))


func update_look_direction(direction: Vector2) -> void:
	# TODO: Change sprite based on look direction
	# TODO: Update rayCast2D direction
	$Pivot/Sprite.rotation = direction.angle()
	$CollisionShape2D.rotation = direction.angle()


func print_direction_info(direction: Vector2) -> void:
	match(direction):
		UP:
			print("UP")
			print(direction.angle())
		RIGHT_UP:
			print("RIGHT_UP")
			print(direction.angle())
		RIGHT:
			print("RIGHT")
			print(direction.angle())
		RIGHT_DOWN:
			print("RIGHT_DOWN")
			print(direction.angle())
		DOWN:
			print("DOWN")
			print(direction.angle())
		LEFT_DOWN:
			print("LEFT_DOWN")
			print(direction.angle())
		LEFT:
			print("LEFT")
			print(direction.angle())
		LEFT_UP:
			print("LEFT_UP")
			print(direction.angle())
