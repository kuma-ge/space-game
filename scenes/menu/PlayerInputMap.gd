extends Control

const input_button_scene = preload("res://scenes/menu/input/InputButton.tscn")

var player_input: PlayerInput = PlayerInput.new()

var inputs = []

func _ready():
	for child in get_children():
		var text = child.text as String
		var input = text.substr("INPUT_".length()).to_lower()
		
		var input_button = input_button_scene.instance()
		input_button.device = player_input.device_id
		input_button.joypad = player_input.joypad_input
		input_button.input = input
		add_child_below_node(child, input_button)

func grab_focus():
	for child in get_children():
		if child is InputButton:
			child.grab_focus()
			return
