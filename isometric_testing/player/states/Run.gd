extends PlayerState

var last_direction


func physics_update(_delta: float) -> void:
	if not Input.is_action_pressed("ui_run"):
		state_machine.transition_to("Walk")

	if player.velocity == Vector2.ZERO:
		state_machine.transition_to("Idle", {facing_direction = last_direction})
	else:
		player.animation_tree.get("parameters/playback").travel("walk")
		player.animation_tree.set("parameters/walk/blend_position", player.velocity)
		last_direction = player.velocity
		player.move_and_slide(player.velocity * player.run_speed)

	if Input.is_action_just_pressed("ui_roll"):
		state_machine.transition_to("Roll", {facing_direction = last_direction, from_state = "Run"})
