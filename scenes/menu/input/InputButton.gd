extends Control

signal read_input()
signal input_change(action, ev)
signal input_finished()

class_name InputButton

export var action = ""

const joypad_map = {
	JOY_XBOX_A: "buttonA",
	JOY_XBOX_B: "buttonB",
	JOY_XBOX_X: "buttonX",
	JOY_XBOX_Y: "buttonY",
	JOY_L: "buttonL1",
	JOY_L2: "buttonL2",
	JOY_R: "buttonR1",
	JOY_R2: "buttonR2",
	JOY_SELECT: "buttonSelect",
	JOY_START: "buttonStart",
	JOY_DPAD_DOWN: "DPAD_down",
	JOY_DPAD_UP: "DPAD_up",
	JOY_DPAD_LEFT: "DPAD_left",
	JOY_DPAD_RIGHT: "DPAD_right",
}

onready var label = $CenterContainer/Label
onready var icon_1 = $CenterContainer/HBoxContainer/TextureRect
onready var icon_2 = $CenterContainer/HBoxContainer/TextureRect2

var allow_input_read = true
var player_input = PlayerInput.new()
var change_input = false
var current_input: InputEvent

func update_button():
	_update_button_for(_get_current_input())


func _get_current_input():
	return current_input


func _input(event):
	if event is InputEventMouseButton:
		_handle_event(event)


func _unhandled_input(event):
	_handle_event(event)

func _handle_event(event: InputEvent) -> void:
	if not change_input or not player_input.is_player_event(event): return
	
	if not event.is_action_pressed("ui_cancel"):
		_update_button_for(event)
		emit_signal("input_change", action, event)
		current_input = event
	else:
		_update_button_for(_get_current_input())
	
	get_tree().set_input_as_handled()
	change_input = false
	emit_signal("input_finished")
	
	
func _update_button_for(ev: InputEvent) -> void:
	label.hide()
	icon_1.hide()
	icon_2.hide()
	
	# TODO: improve joypad mapping, seems weird
	if PlayerInput.is_joypad_event(ev) or ev is InputEventMouseButton:
		var img1 = "question"
		var img2 = ""
		
		if ev is InputEventJoypadButton:
			if joypad_map.has(ev.button_index):
				img1 = joypad_map.get(ev.button_index)
		elif ev is InputEventJoypadMotion:
			if ev.axis == JOY_AXIS_0 || ev.axis == JOY_AXIS_1:
				img1 = "joystickL_top"
			elif ev.axis == JOY_AXIS_2 || ev.axis == JOY_AXIS_3:
				img1 = "joystickR_top"
			
			if ev.axis_value != 0:
				if ev.axis in [JOY_AXIS_0, JOY_AXIS_2]:
					img2 = "arrowRight" if ev.axis_value > 0 else "arrowLeft"
				elif ev.axis in [JOY_AXIS_1, JOY_AXIS_3]:
					img2 = "arrowUp" if ev.axis_value > 0 else "arrowDown" 
		elif ev is InputEventMouseButton:
			if ev.button_index == BUTTON_LEFT:
				img1 = "mouseRight"
			elif ev.button_index == BUTTON_RIGHT:
				img1 = "mouseLeft"
			elif ev.button_index == BUTTON_MIDDLE:
				img1 = "mouseMiddle"
		
		_set_icon(icon_1, img1)
		_set_icon(icon_2, img2)
	elif ev != null:
		label.text = "?"
		if ev is InputEventKey:
			label.text = OS.get_scancode_string(ev.scancode)
		
		label.show()


func _set_icon(icon: TextureRect, img: String):
	if img != "":
		icon.texture = load(_get_joypad_icon(img))
		icon.rect_min_size = Vector2(label.rect_size.y, label.rect_size.y)
		icon.show()


func _get_joypad_icon(img: String) -> String:
	return Utils.get_script_path(self) + img + ".png"


func _on_InputButton_pressed():
	if not allow_input_read: return
	
	change_input = true
	_update_button_for(null)
	label.text = tr("PRESS_ANY_BUTTON")
	label.show()
	emit_signal("read_input")
