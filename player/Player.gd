class_name Player
extends KinematicBody2D

signal died

export var speed_max := 675.0
export var acceleration := 1500.0
export var angular_speed_max := deg2rad(150)
export var angular_acceleration := deg2rad(1200)
export var drag_factor := 0.05
export var angular_drag_factor := 0.1
export var speed_boost := 1.5

onready var bullet_spawner := $BulletSpawner
onready var health := $Health
onready var boost := $boost

const hit_effect = preload("res://player/hiteffect/HitEffect.tscn")

const colors = [
	Color.white,
	Color.green,
	Color.orange,
	Color.violet,
]

var velocity := Vector2.ZERO
var angular_velocity := 0.0

var input: PlayerInput
var player_number: int setget _set_player_number

func _set_player_number(num: int) -> void:
	player_number = num
	$player.modulate = colors[num % colors.size()]


func turn(dir: Vector2) -> void:
	rotation = Vector2.UP.angle_to(dir)


func _physics_process(delta: float) -> void:
	bullet_spawner.spawn = input.is_pressed("fire")
	
	var speed = speed_max
	if input.is_pressed("boost"):
		speed *= speed_boost
	velocity = velocity.clamped(speed)
	boost.visible = input.is_pressed("boost") and velocity.length() > 1

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


func _on_HurtBox_damaged(dmg):
	health.reduce(dmg)
	var hit = hit_effect.instance()
	add_child(hit)


func _on_Health_zero_health():
	queue_free()
	emit_signal("died")
