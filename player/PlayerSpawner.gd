extends Node

class_name PlayerSpawner

const player_scene = preload("res://player/Player.tscn")

func create_players() -> Array:
	var players = []
	var player_idx = 0
	for player in Globals.player_manager.get_inputs():
		var player_node = create_player(player_idx)
		players.append(player_node)
		player_idx += 1
	return players

func create_player(num: int) -> Player:
	var player_node = player_scene.instance()
	player_node.input = Globals.player_manager.get_input(num)
	player_node.player_number = num
	return player_node
