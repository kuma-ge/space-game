extends Node

onready var player_manager := $PlayerManager
onready var gui := $GUI
onready var death_match := $Deathmatch

func _ready():
	gui.show_main_menu().connect("start_game", self, "_start_player_select")
	
func _start_player_select():
	gui.show_player_selection(player_manager).connect("start_game", self, "_start_game")

func _start_game():
	gui.hide_active()
	death_match.start_game(player_manager)
