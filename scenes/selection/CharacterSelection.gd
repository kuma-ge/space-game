extends Control

signal player_ready(ready)

enum Ship {
	A,
	B,
	C,
	D,
	E,
	F,
	G,
	H,
	I,
	J,
	K,
	L,
}

onready var ships = $VBoxContainer/GridContainer
onready var ready_label := $VBoxContainer/Ready
onready var gamepad := $VBoxContainer/TextureRect

const ship_select_scene = preload("res://scenes/selection/ShipSelect.tscn")

var input: PlayerInput setget _set_input
var ready = false setget _set_ready

#func _ready():
#	for ship in Ship.keys():
#		var file = "res://player/ship_" + ship + ".png"
#		var png = load(file)
#		var ship_select = ship_select_scene.instance()
#		ships.add_child(ship_select)
#		ship_select.texture.texture = png


func _unhandled_input(event):
	if not input: return
	
	if not ready and input.is_pressed("ui_accept"):
		self.ready = true
		emit_signal("player_ready", true)
	elif ready and input.is_pressed("ui_cancel"):
		self.ready = false
		emit_signal("player_ready", false)


func _set_input(i: PlayerInput) -> void:
	input = i
	$VBoxContainer/GridContainer.set_input(i)


func _set_ready(value: bool) -> void:
	ready = value
	ready_label.text = tr("READY") if ready else ""


func set_number(num: int) -> void:
	var file = Utils.get_script_path(self) + "gamepad" + str(num) + ".png"
	$VBoxContainer/TextureRect.texture = load(file)
