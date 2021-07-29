extends Area2D

onready var collision := $CollisionShape2D

func set_size(size: float) -> void:
	var shape = collision.shape as RectangleShape2D
	shape.extents.x = size
