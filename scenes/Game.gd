extends Node

onready var player_manager := $PlayerManager
onready var gui := $CanvasLayer
onready var camera := $Camera2D

const selection_scene = preload("res://scenes/selection/PlayerSelection.tscn")
const player_scene = preload("res://player/Player.tscn")

func _ready():
	MainMenu.connect("start_game", self, "_start_player_select")

func _start_player_select():
	var selection = selection_scene.instance()
	selection.player_manager = player_manager
	gui.add_child(selection)
	selection.connect("start_game", self, "_start_game")
	
func _start_game():
	for player in player_manager.players:
		var player_node = player_scene.instance()
		add_child(player_node)
		player_node.input = player_manager.create_input(player)
		camera.add_track_node(player_node)
