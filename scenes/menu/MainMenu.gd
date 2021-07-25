extends Control

class_name MainMenu

onready var main := $Main
onready var options := $Options
onready var stack := $MenuStack

onready var start_btn = $Main/VBoxContainer/Start


func _ready():
	_hide_all()
	stack.connect("menu_changed", self, "_menu_changed")
	stack.open_menu(main)


func _hide_all():
	for child in get_children():
		if child is Control:
			child.hide()


func _menu_changed():
	_hide_all()
	if stack.current_menu != null:
		stack.current_menu.show()


func _on_Start_pressed():
	Gui.open_menu(Gui.Screen.PlayerSelection)


func _on_Options_pressed():
	stack.open_menu(options)


func _on_Exit_pressed():
	get_tree().quit()
