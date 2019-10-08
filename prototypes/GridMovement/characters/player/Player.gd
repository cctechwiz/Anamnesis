extends KinematicBody2D
class_name Player

export(int) var max_speed: = 400

onready var grid: = get_parent()
onready var type = get_parent().ENTITY_TYPES.PLAYER

var velocity: = Vector2.ZERO
var is_moving: = false
var target_position: = Vector2.ZERO
var target_direction: = Vector2.ZERO


func _ready() -> void:
	# The default look direction is RIGHT
	update_look_direction(Vector2.DOWN)


func _physics_process(delta: float) -> void:
	var input_direction: Vector2 = get_input_direction()
	var speed: = 0

	# print_direction_info(input_direction)
	update_look_direction(target_direction)

	# Prevent diagonal movement
	if input_direction.x != 0 and input_direction.y != 0:
		input_direction = Vector2.ZERO

	if not is_moving and input_direction != Vector2.ZERO:
		if grid.is_cell_vacant(position, input_direction):
			target_direction = input_direction.normalized()
			target_position = grid.update_child_pos(self, input_direction)
			is_moving = true

	elif is_moving:
		speed = max_speed
		velocity = target_direction * speed * delta

		# Ensure that the player stops on his target
		var distance_to_target: = position.distance_to(target_position)
		var move_distance: = velocity.length()
		if distance_to_target < move_distance:
			velocity = target_direction * distance_to_target
			is_moving = false

		move_and_collide(velocity)



func get_input_direction() -> Vector2:
	var left: bool = Input.is_action_pressed("ui_left")
	var right: bool = Input.is_action_pressed("ui_right")
	var up: bool = Input.is_action_pressed("ui_up")
	var down: bool = Input.is_action_pressed("ui_down")

	return Vector2(int(right) - int(left), int(down) - int(up))


func update_look_direction(direction: Vector2) -> void:
	$Pivot/Sprite.rotation = direction.angle()
	$CollisionShape2D.rotation = direction.angle()


func print_direction_info(direction: Vector2) -> void:
	match(direction):
		Vector2.UP:
			print("UP")
			print(direction.angle())
		Vector2.RIGHT + Vector2.UP:
			print("RIGHT_UP")
			print(direction.angle())
		Vector2.RIGHT:
			print("RIGHT")
			print(direction.angle())
		Vector2.RIGHT + Vector2.DOWN:
			print("RIGHT_DOWN")
			print(direction.angle())
		Vector2.DOWN:
			print("DOWN")
			print(direction.angle())
		Vector2.LEFT + Vector2.DOWN:
			print("LEFT_DOWN")
			print(direction.angle())
		Vector2.LEFT:
			print("LEFT")
			print(direction.angle())
		Vector2.LEFT + Vector2.UP:
			print("LEFT_UP")
			print(direction.angle())
