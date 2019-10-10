extends "res://src/Core/Grid/Gridable.gd"

onready var Grid: = get_parent()

func _ready() -> void:
	# TODO: Ensure the player is aligned to "the grid" (aka a multiple of 32)
	update_look_direction(Vector2.DOWN)


func _process(delta: float) -> void:
	var input_direction = get_input_direction() # TODO: Should this move to _input() ?
	if not input_direction:
		return

	update_look_direction(input_direction)

	# This line tightly couples the player to the grid
	#var target_position: Vector2 = Grid.request_move(self, input_direction)

	# TEMP: Just move the player to the next "grid space" position
	var target_position: Vector2 = position + (input_direction * 64)

	if target_position:
		move_to(target_position)
	else:
		bump()


func get_input_direction() -> Vector2:
	# TODO: experiment with disabling diagonal movement
	return Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	)


func update_look_direction(look_towards: Vector2) -> void:
	$Pivot/Sprite.rotation = look_towards.angle()


func move_to(target_position: Vector2) -> void:
	set_process(false)
	$AnimationPlayer.play("walk")

	var move_direction: = (target_position - position).normalized()
	$Tween.interpolate_property($Pivot, "position", - move_direction * 32, Vector2(), $AnimationPlayer.current_animation_length, Tween.TRANS_LINEAR, Tween.EASE_IN)
	position = target_position

	yield($AnimationPlayer, "animation_finished")
	set_process(true)


func bump() -> void:
	set_process(false)
	$AnimationPlayer.play("bump")
	yield($AnimationPlayer, "animation_finished")
	set_process(true)
