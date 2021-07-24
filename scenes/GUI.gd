extends CanvasLayer

class_name GUI

const main_menu = preload("res://scenes/menu/MainMenu.tscn")
const selection_scene = preload("res://scenes/selection/PlayerSelection.tscn")
const pause_menu = preload("res://scenes/pause/PauseMenu.tscn")
const game_over_menu = preload("res://scenes/gameover/GameOver.tscn")

var active: Node

func _ready():
	show_main_menu()

func _unhandled_input(event):
	if active == null and event.is_action_pressed("ui_cancel"):
		show_pause_menu()

func show_main_menu():
	Events.emit_signal("main_menu")
	Globals.game_started = false
	var menu = _show_scene(main_menu) as MainMenu
	menu.connect("start_game", self, "_show_player_selection")

func _show_player_selection():
	var selection = _show_scene(selection_scene) as PlayerSelection
	selection.connect("start_game", self, "_start_game")
	selection.connect("back", self, "show_main_menu")
	
func _start_game():
	hide_active()
	Globals.game_started = true
	Events.emit_signal("game_started")


func show_pause_menu():
	if Globals.game_started and not get_tree().paused:
		var pause = _show_scene(pause_menu) as PauseMenu


func show_game_over():
	Globals.game_started = false
	_show_scene(game_over_menu)


func hide_active(hide_bg = true) -> void:
	if active and active.is_inside_tree():
		remove_child(active)
	active = null


func _show_scene(scene: PackedScene):
	hide_active(false)
	active = scene.instance()
	add_child(active)
	return active
