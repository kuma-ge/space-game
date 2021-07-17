extends Control

onready var btn_container := $VBoxContainer

const buttons = []

func _ready():
	for child in btn_container.get_children():
		buttons.append(child)

func show():
	.show()
	if buttons.size() > 0:
		buttons[0].grab_focus()
