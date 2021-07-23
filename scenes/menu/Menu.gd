extends Control

func _ready():
	focus_first()

func focus_first():
	if get_child_count() > 0:
		get_child(0).grab_focus()
