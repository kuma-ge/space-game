extends Control

const input_button_scene = preload("res://scenes/menu/input/InputButton.tscn")

var player_input: PlayerInput = PlayerInput.new()

var profile: InputProfile
var mappable_actions = []
var inputs = []
var waiting_input = false

func _ready():
	for child in get_children():
		if not child is Label: continue
		
		var text = child.text as String
		var action = text.substr("INPUT_".length()).to_lower()
		mappable_actions.append(action)
		
		var input_button = input_button_scene.instance()
		input_button.player_input = player_input
		input_button.action = action
		input_button.connect("read_input", self, "set_input_button_allow", [false])
		input_button.connect("input_finished", self, "set_input_button_allow", [true])
		add_child_below_node(child, input_button)
		inputs.append(input_button)
	
	
	profile = InputProfile.new(player_input, mappable_actions)
	for input in inputs:
		input.current_input = profile.get_current_input(input.action)
		input.connect("input_change", profile, "change_input")
		input.update_button()

func set_input_button_allow(value: bool) -> void:
	for input in inputs:
		input.allow_input_read = value

func grab_focus():
	for child in get_children():
		if child is InputButton:
			child.grab_focus()
			return
