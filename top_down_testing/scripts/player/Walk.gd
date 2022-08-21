extends PlayerState

var last_direction


func physics_update(_delta: float) -> void:
	if player.velocity == Vector2.ZERO:
		state_machine.transition_to("Idle", {facing_direction = last_direction})
	else:
		player.animation_tree.get("parameters/playback").travel("walk")
		player.animation_tree.set("parameters/walk/blend_position", player.velocity)
		last_direction = player.velocity
		player.move_and_slide(player.velocity * player.walk_speed)
