extends Node

onready var player_manager := $PlayerManager
onready var gui := $GUI

const player_scene = preload("res://player/Player.tscn")

func _ready():
	gui.show_main_menu().connect("start_game", self, "_start_player_select")
	
func _start_player_select():
	gui.show_player_selection(player_manager).connect("start_game", self, "_start_game")

func _start_game():
	gui.hide_active()
	for player in player_manager.players:
		var player_node = player_scene.instance()
		add_child(player_node)
		player_node.input = player_manager.create_input(player)
