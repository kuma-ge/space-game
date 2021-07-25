extends Node

onready var player_manager := $PlayerManager

var game_started = false

func _ready():
	Events.connect("game_started", self, "_on_game_started")
	Events.connect("game_ended", self, "_on_game_ended")
	
func _on_game_started(mode) -> void:
	game_started = true
	
func _on_game_ended(finished: bool) -> void:
	game_started = false
