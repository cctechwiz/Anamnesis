extends PlayerState


var previous_state
var facing_direction
var roll_speed


func enter(msg := {}) -> void:
	if msg.has("from_state"):
		previous_state = msg.from_state
	match previous_state:
		"Walk":
			roll_speed = player.walk_speed * 1.5
		"Run":
			roll_speed = player.run_speed * 1.5
		_:
			roll_speed = player.roll_speed
	if msg.has("facing_direction"):
		facing_direction = msg.facing_direction
		player.animation_tree.set("parameters/roll/blend_position", facing_direction)
	player.velocity = facing_direction
	player.animation_tree.get("parameters/playback").travel("roll")


func physics_update(_delta: float) -> void:
	player.move_and_slide(player.velocity * roll_speed)


func finish_roll() -> void:
	state_machine.transition_to(previous_state, {facing_direction = facing_direction})
