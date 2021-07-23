extends Node

class_name PlayerManager

signal player_added(player, player_num)

export var max_players = 4

var players = []

func _is_join_event(event: InputEvent) -> bool:
	return event.is_action_pressed("ui_accept")


func _is_max_players() -> bool:
	return players.size() >= max_players


func add_player(event: InputEvent) -> void:
	if not _is_join_event(event) or _is_max_players(): return
	
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
	return find_player_index(player_data) != -1

func find_player_index(player: Dictionary) -> int:
	for i in range(0, players.size()):
		var input = players[i]
		if input["device"] == player["device"] and \
			input["joypad"] == player["joypad"]:
			return i
	return -1


func reset_players() -> void:
	players.clear()


func create_input(player) -> PlayerInput:
	return PlayerInput.new(player["device"], player["joypad"])
