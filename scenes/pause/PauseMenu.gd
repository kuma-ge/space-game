extends Control

signal resume
signal back_menu

class_name PauseMenu

func _on_Exit_pressed():
	get_tree().quit()


func _on_Resume_pressed():
	get_tree().paused = false
	Gui.hide_active()


func _on_BackMenu_pressed():
	get_tree().paused = false
	Gui.show_main_menu()
