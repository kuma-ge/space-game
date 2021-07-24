extends StaticBody2D

enum Side {
	TOP,
	BOTTOM,
	LEFT,
	RIGHT,
}

export(Side) var size: int

export var camera_path: NodePath
onready var camera: Camera2D = get_node(camera_path)

onready var collision := $CollisionShape2D
onready var color := $ColorRect

func _ready():
	var multipler = (1.0 / 2.0) * camera.zoom.x
	var shape = RectangleShape2D.new()
	collision.shape = shape
	
	if size == Side.TOP:
		shape.extents = Vector2(get_viewport().size.x * multipler, 5)
		global_position.y -= get_viewport().size.y * multipler
	elif size == Side.BOTTOM:
		shape.extents = Vector2(get_viewport().size.x * multipler, 5)
		global_position.y += get_viewport().size.y * multipler
	elif size == Side.LEFT:
		shape.extents = Vector2(5, get_viewport().size.y * multipler)
		global_position.x -= get_viewport().size.x * multipler
	elif size == Side.RIGHT:
		shape.extents = Vector2(5, get_viewport().size.y * multipler)
		global_position.x += get_viewport().size.x * multipler
	
	color.rect_size = shape.extents * 2
	color.rect_position = color.rect_size / -2
