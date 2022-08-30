extends PlayerState


func enter(msg := {}) -> void:
	if msg.has("facing_direction"):
		player.animation_tree.set("parameters/idle/blend_position", msg.facing_direction)

	player.velocity = Vector2.ZERO
	player.animation_tree.get("parameters/playback").travel("idle")


func physics_update(_delta: float) -> void:
	if player.velocity != Vector2.ZERO:
		state_machine.transition_to("walk")
