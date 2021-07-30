extends StaticBody2D

onready var visibility := $VisibilityNotifier2D

func is_visible_on_screen():
	return visibility.is_on_screen()
