extends Node2D

const player_scene = preload("res://player/Player.tscn")

onready var player_spawner := $PlayerSpawner

func _ready():
	for player in player_spawner.create_players():
		add_child(player)
