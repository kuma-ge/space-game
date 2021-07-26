extends Control

class_name MainMenu

onready var main := $Main
onready var options := $Options
onready var stack := $MenuStack

onready var start_btn = $Main/VBoxContainer/Start


func _ready():
	_hide_all()
	stack.connect("changed", self, "_menu_changed")
	stack.push(main)


func _hide_all():
	for child in get_children():
		if child is Control:
			child.hide()


func _menu_changed():
	_hide_all()
	if stack.current != null:
		stack.current.show()


func _on_Start_pressed():
	Gui.open_menu(Gui.Screen.PlayerSelection)


func _on_Options_pressed():
	stack.push(options)


func _on_Exit_pressed():
	get_tree().quit()
