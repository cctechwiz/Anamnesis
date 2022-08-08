extends PlayerState

var last_direction


func physics_update(_delta: float) -> void:
	player.velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		player.velocity.x += 1.0
	if Input.is_action_pressed("ui_left"):
		player.velocity.x -= 1.0
	if Input.is_action_pressed("ui_down"):
		player.velocity.y += 1.0
	if Input.is_action_pressed("ui_up"):
		player.velocity.y -= 1.0

	player.velocity = player.velocity.normalized()

	# TODO: Move this to separate Run state
	var speed = player.walk_speed
	if Input.is_action_pressed("ui_run"):
		speed = player.run_speed

	if player.velocity == Vector2.ZERO:
		state_machine.transition_to("Idle", {facing_direction = last_direction})
	else:
		player.animation_tree.get("parameters/playback").travel("walk")
		player.animation_tree.set("parameters/walk/blend_position", player.velocity)
		last_direction = player.velocity
		player.move_and_slide(player.velocity * speed)
