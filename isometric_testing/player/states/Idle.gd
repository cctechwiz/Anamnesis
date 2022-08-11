extends PlayerState

var facing_direction

func enter(msg := {}) -> void:
	if msg.has("facing_direction"):
		player.animation_tree.set("parameters/idle/blend_position", msg.facing_direction)
		facing_direction = msg.facing_direction
	player.velocity = Vector2.ZERO
	player.animation_tree.get("parameters/playback").travel("idle")


func physics_update(_delta: float) -> void:
	if player.velocity != Vector2.ZERO:
		if Input.is_action_pressed("ui_run"):
			state_machine.transition_to("Run")
		else:
			state_machine.transition_to("Walk")

	if Input.is_action_just_pressed("ui_roll"):
		state_machine.transition_to("Roll", {facing_direction = facing_direction, from_state = "Idle"})
