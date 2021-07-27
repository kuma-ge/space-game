extends Node

class_name PlayerSpawner

const player_scene = preload("res://player/Player.tscn")

func create_players() -> Array:
	var players = []
	var player_idx = 0
	for player in Globals.player_manager.get_inputs():
		var player_node = player_scene.instance()
		players.append(player_node)
		player_node.input = player
		player_node.player_number = player_idx
		player_idx += 1
	return players
