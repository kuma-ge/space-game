extends Node

const mode_map = {
	MapSelection.Mode.DEATHMATCH: preload("res://maps/Deathmatch.tscn"),
	MapSelection.Mode.RACE: preload("res://maps/Race.tscn")
}

var active_game

func _ready():
	Events.connect("game_started", self, "_start_game")
	Events.connect("gui_changed", self, "_handle_gui_changed")
	Gui.open_menu(Gui.Screen.MainMenu)

func _start_game(mode):
	if not mode_map.has(mode):
		print("Invalid Mode")
		return
	
	var game = mode_map[mode]
	active_game = game.instance()
	add_child(active_game)


func _handle_gui_changed(screen):
	if Gui.Screen.MainMenu == screen and active_game:
		_end_game()

func _end_game():
	active_game.queue_free()
	active_game = null
