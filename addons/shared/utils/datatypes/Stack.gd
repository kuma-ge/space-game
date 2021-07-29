extends Node

class_name Stack

signal changed()

const stack = []

var current setget _set_current

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		pop()


func _set_current(value) -> void:
	current = value
	emit_signal("changed")


func pop():
	if stack.size() == 0:
		return
	
	var last = stack.pop_back()
	self.current = last


func push(value):
	if current != null:
		stack.push_back(current)
	self.current = value

func clear():
	stack.clear()
	self.current = null
