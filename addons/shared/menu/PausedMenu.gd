extends Control

class_name PausedMenu

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	_pause()
	connect("tree_exiting", self, "_resume")
	
func _pause():
	get_tree().paused = true

func _resume():
	get_tree().paused = false
