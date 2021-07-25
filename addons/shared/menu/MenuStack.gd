extends Node

class_name MenuStack

signal menu_changed()

const menu_stack = []

var current_menu setget _set_current_menu

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		_back_menu()


func _set_current_menu(menu) -> void:
	current_menu = menu
	emit_signal("menu_changed")


func _back_menu():
	if menu_stack.size() == 0:
		return
	
	var last_menu = menu_stack.pop_back()
	self.current_menu = last_menu


func open_menu(menu):
	if current_menu != null:
		menu_stack.push_back(current_menu)
	self.current_menu = menu

func clear_menu():
	menu_stack.clear()
	self.current_menu = null
