class_name Player
extends KinematicBody2D

export var speed_max := 675.0
export var acceleration := 1500.0
export var angular_speed_max := deg2rad(150)
export var angular_acceleration := deg2rad(1200)
export var drag_factor := 0.05
export var angular_drag_factor := 0.1

var velocity := Vector2.ZERO
var angular_velocity := 0.0

var input: PlayerInput setget _set_input

func _set_input(i: PlayerInput) -> void:
	add_child(i)
	input = i


func _physics_process(delta: float) -> void:
	print(_get_movement())
	velocity = velocity.clamped(speed_max)

	angular_velocity = clamp(angular_velocity, -angular_speed_max, angular_speed_max)
	angular_velocity = lerp(angular_velocity, 0, angular_drag_factor)

	velocity = move_and_slide(velocity)
	rotation += angular_velocity * delta

	var movement := _get_movement()
	
	if is_equal_approx(movement.y, 0):
		velocity = (velocity.linear_interpolate(Vector2.ZERO, drag_factor))

	var direction := Vector2.UP.rotated(rotation)

	velocity += movement.y * direction * acceleration * delta
	angular_velocity += movement.x * angular_acceleration * delta


func _get_movement() -> Vector2:
	return Vector2(
		input.get_action_strength("move_right") - input.get_action_strength("move_left"),
		input.get_action_strength("move_up") - input.get_action_strength("move_down")
	)
