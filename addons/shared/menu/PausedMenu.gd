extends Control

class_name PausedMenu

func _ready():
	connect("tree_entered", self, "_pause")
	connect("tree_exiting", self, "_resume")
	
func _pause():
	get_tree().paused = true
	print("Pause")

func _resume():
	get_tree().paused = false
	print("Resume")
