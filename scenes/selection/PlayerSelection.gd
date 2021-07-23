extends Control

class_name PlayerSelection

signal start_game

onready var selection_container := $VBoxContainer/GridContainer
onready var start_btn := $VBoxContainer/Start

const selection_scene = preload("res://scenes/selection/CharacterSelection.tscn")

onready var player_manager := Globals.player_manager

func _ready():
	player_manager.connect("player_added", self, "_add_player_selection")


func _unhandled_input(event):
	player_manager.add_player(event)


func _add_player_selection(player, player_num) -> void:
	var input = player_manager.create_input(player)
	player_manager.add_child(input)
	
	var selection = selection_scene.instance()
	selection_container.add_child(selection)
	selection.set_number(player_num)
	selection.connect("player_ready", self, "_update_start_button")
	selection.input = input
	_update_start_button(null)


func _update_start_button(ready) -> void:
	start_btn.disabled = not _all_players_ready()


func _all_players_ready() -> bool:
	for child in selection_container.get_children():
		if not child.ready:
			return false
	return true


func _on_Start_pressed():
	if not _all_players_ready(): return
	
	emit_signal("start_game")
	queue_free()
