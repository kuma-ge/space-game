extends Control

class_name MapSelection

enum Mode {
	DEATHMATCH,
	RACE,
}


func _on_Deathmatch_pressed():
	Events.emit_signal("game_started", Mode.DEATHMATCH)


func _on_Race_pressed():
	Events.emit_signal("game_started", Mode.RACE)
