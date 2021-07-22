extends Node2D

const player_scene = preload("res://player/Player.tscn")

onready var space := $Space

var _player_spawned = 0

func start_game(player_manager):
	for player in player_manager.players:
		var player_node = player_scene.instance()
		add_child(player_node)
		var pos = _get_next_position()
		player_node.global_position = pos
		player_node.input = player_manager.create_input(player)
		_player_spawned += 1

func _get_next_position() -> Vector2:
	var dir = _get_spawn_direction()
	var spawn_offset = get_viewport().size / 1.5
	var continue_offset = 1.005
	var spawn_pos = dir * spawn_offset
	
	while space.is_occupied(spawn_pos):
		spawn_pos *= continue_offset
	
	return spawn_pos

func _get_spawn_direction() -> Vector2:
	if _player_spawned == 0:
		return Vector2.LEFT
	elif _player_spawned == 1:
		return Vector2.RIGHT
	elif _player_spawned == 2:
		return Vector2.UP
	elif _player_spawned == 3:
		return Vector2.DOWN
	return Vector2.ZERO
