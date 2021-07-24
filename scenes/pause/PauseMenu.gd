extends PausedMenu

class_name PauseMenu


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel") or event.is_action_pressed("menu"):
		get_tree().set_input_as_handled()
		_on_Resume_pressed()


func _on_Exit_pressed():
	get_tree().quit()


func _on_Resume_pressed():
	Gui.hide_active()


func _on_BackMenu_pressed():
	Gui.show_main_menu()
