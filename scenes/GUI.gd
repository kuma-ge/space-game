extends CanvasLayer

class_name GUI

enum Screen {
	MainMenu,
	PlayerSelection,
	Pause,
	GameOver,
	ModeSelection,
	InGame,
}

const screen_scene_map = {
	Screen.MainMenu: preload("res://scenes/menu/MainMenu.tscn"),
	Screen.PlayerSelection: preload("res://scenes/selection/PlayerSelection.tscn"),
	Screen.Pause: preload("res://scenes/pause/PauseMenu.tscn"),
	Screen.GameOver: preload("res://scenes/gameover/GameOver.tscn"),
	Screen.ModeSelection: preload("res://scenes/map_selection/MapSelection.tscn"),
}

onready var stack := $MenuStack
onready var theme := $Theme

func _ready():
	Events.connect("game_started", self, "_game_started")
	Events.connect("game_ended", self, "_game_ended")
	
	stack.connect("menu_changed", self, "_menu_changed")
	stack.open_menu(Screen.MainMenu)


func _unhandled_input(event):
	if Globals.game_started and event.is_action_pressed("menu"):
		show_pause_menu()


func show_pause_menu():
	if not get_tree().paused:
		stack.open_menu(Screen.Pause)


func _game_started(mode) -> void:
	open_menu(Screen.InGame)


func _game_ended(finished: bool) -> void:
	if finished:
		open_menu(Screen.GameOver)
	else:
		open_menu(Screen.MainMenu)


func open_menu(menu):
	stack.open_menu(menu)


func _remove_active_menu():
	for child in theme.get_children():
		theme.remove_child(child)


func _menu_changed():
	_remove_active_menu()
	
	var menu = stack.current_menu
	if screen_scene_map.has(menu):
		var scene = screen_scene_map[menu]
		theme.add_child(scene.instance())
		Events.emit_signal("gui_changed", menu)

