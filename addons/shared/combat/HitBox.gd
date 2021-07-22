extends Area2D

class_name HitBox

export var damage = 1
export var free_on_hit = true

var ignored_nodes = []

func _ready():
	connect("area_entered", self, "_on_HitBox_area_entered")
	connect("body_entered", self, "_on_HitBox_body_entered")

func _on_HitBox_area_entered(area):
	if _is_ignored_node(area): return
	
	if area is HurtBox:
		area.damage(damage)
		queue_free()

func _on_HitBox_body_entered(body):
	if _is_ignored_node(body): return
	
	queue_free()

func _is_ignored_node(node):
	for ignored_node in ignored_nodes:
		if node == ignored_node:
			return true
	return false

func add_ignored_node(node):
	ignored_nodes.append(node)
