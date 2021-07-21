extends CanvasLayer

class_name GUI

export var player_manager_path: NodePath
onready var player_manager: PlayerManager = get_node(player_manager_path)

onready var background := $ColorRect

const main_menu = preload("res://scenes/menu/MainMenu.tscn")
const selection_scene = preload("res://scenes/selection/PlayerSelection.tscn")

var active

func show_main_menu() -> MainMenu:
	return _show_scene(main_menu)


func show_player_selection(player_manager: PlayerManager) -> PlayerSelection:
	return _show_scene(selection_scene, {
		"player_manager": player_manager
	})


func hide_active(hide_bg = true) -> void:
	if active:
		remove_child(active)
	
	if hide_bg:
		background.hide()


func _show_scene(scene: PackedScene, props: Dictionary = {}):
	hide_active(false)
	active = scene.instance()
	for prop in props:
		active.set(prop, props[prop])
	add_child(active)
	return active
