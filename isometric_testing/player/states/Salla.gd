# Player with top-down movement, rolling, and attacking
class_name Player
extends KinematicBody2D

export var walk_speed := 150.0
export var run_speed := 250.0

onready var animation_tree := $AnimationTree

var velocity
