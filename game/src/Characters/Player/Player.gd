extends Node2D

func _ready() -> void:
	update_look_direction(Vector2.DOWN)


func _process(delta: float) -> void:
	var input_direction = get_input_direction() # TODO: Should this move to _input() ?
	if not input_direction:
		return

	update_look_direction(input_direction)


func get_input_direction() -> Vector2:
	return Vector2(
		int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left")),
		int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	)


func update_look_direction(look_towards: Vector2) -> void:
	$Pivot/Sprite.rotation = look_towards.angle()
