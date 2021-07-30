extends Control

class_name MainMenu


func _on_Start_pressed():
	Gui.open_menu(Gui.Screen.PlayerSelection)


func _on_Options_pressed():
	Gui.open_menu(Gui.Screen.Options)


func _on_Exit_pressed():
	get_tree().quit()
