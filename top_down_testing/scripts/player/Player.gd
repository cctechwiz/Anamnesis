# Player with top-down movement, rolling, and attacking
class_name Player
extends KinematicBody2D

export var walk_speed := 150.0
export var run_speed := 250.0
export var roll_speed := 200.0

onready var animation_tree := $AnimationTree

var velocity


func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1.0
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1.0
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1.0
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1.0

	velocity = velocity.normalized()
