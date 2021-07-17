extends Node

class_name PlayerManager

signal player_added(player, player_num)

var players = []

func _is_join_event(event: InputEvent) -> bool:
	return event.is_action_pressed("ui_accept")


func add_player(event: InputEvent) -> void:
	if not _is_join_event(event): return
	
	var data = {
		"device": event.device,
		"joypad": PlayerInput.is_joypad_event(event),
	}
	
	if player_exists(data):
		print("Player already exists")
		return
	
	players.append(data)
	emit_signal("player_added", data, players.size())
	print("Player added: " + str(data))


func player_exists(player_data: Dictionary) -> bool:
	for input in players:
		if input["device"] == player_data["device"] and \
			input["joypad"] == player_data["joypad"]:
			return true
	return false

func create_input(player) -> PlayerInput:
	return PlayerInput.new(player["device"], player["joypad"])
