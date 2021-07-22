extends Spawner

export var ignore_node_path: NodePath
onready var ignore_node = get_node(ignore_node_path)



func _instance_scene():
	var hitbox: HitBox = ._instance_scene()
	hitbox.add_ignored_node(ignore_node)
	return hitbox
