extends Node

const death_match_scene = preload("res://maps/Deathmatch.tscn")

var active_game

func _ready():
	Events.connect("game_started", self, "_start_game")
	Events.connect("main_menu", self, "_main_menu")

func _start_game():
	active_game = death_match_scene.instance()
	add_child(active_game)

func _main_menu():
	if active_game:
		active_game.queue_free()
