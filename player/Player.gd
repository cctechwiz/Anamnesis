extends KinematicBody2D

export (int) var speed := 200


func _physics_process(delta: float):
	var input_direction: Vector2 = get_input_direction()
	move(input_direction)


func get_input_direction():
	var left: bool = Input.is_action_pressed("ui_left")
	var right: bool = Input.is_action_pressed("ui_right")
	var up: bool = Input.is_action_pressed("ui_up")
	var down: bool = Input.is_action_pressed("ui_down")

	var input_direction := Vector2(
		-int(left) + int(right),
		-int(up) + int(down)
	)

	# Prevent diagonal movement
	if input_direction.x != 0 and input_direction.y != 0:
		input_direction = Vector2.ZERO

	return input_direction


func move(input_direction: Vector2):
	var velocity: Vector2 = (input_direction.normalized() * speed)
	move_and_slide(velocity, Vector2.ZERO)