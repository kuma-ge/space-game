extends Control

onready var player_manager = $PlayerManager

func _ready():
	player_manager.connect("player_added", self, "add_player")
	
func _unhandled_input(event):
	player_manager.add_player(event)
