extends KinematicBody2D

export (int) var speed := 200
var input_direction := Vector2.ZERO
var sprite_direction := "down"


func _physics_process(delta: float):
	get_input_direction()
	move()
	update_sprite()

	if input_direction != Vector2.ZERO:
		update_animation("walk")
	else:
		update_animation("idle")


func get_input_direction():
	var left: bool = Input.is_action_pressed("ui_left")
	var right: bool = Input.is_action_pressed("ui_right")
	var up: bool = Input.is_action_pressed("ui_up")
	var down: bool = Input.is_action_pressed("ui_down")

	input_direction = Vector2(
		-int(left) + int(right),
		-int(up) + int(down)
	)

	# Prevent diagonal movement
	#if input_direction.x != 0 and input_direction.y != 0:
	#	input_direction = Vector2.ZERO


func move():
	var velocity: Vector2 = (input_direction.normalized() * speed)
	return move_and_slide(velocity, Vector2.ZERO)


func update_sprite():
	match input_direction:
		Vector2(-1, 0):
			sprite_direction = "left"
		Vector2(1, 0):
			sprite_direction = "right"
		Vector2(0, -1):
			sprite_direction = "up"
		Vector2(0, 1):
			sprite_direction = "down"


func update_animation(animation):
	var new_animation = animation + "_" + sprite_direction
	if $Animation.current_animation != new_animation:
		$Animation.play(new_animation)
