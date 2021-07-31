extends Control

class_name InputButton

export var device = 0
export var input = ""
export var joypad = false

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
}

onready var label = $CenterContainer/Label
onready var joypad_icon_1 = $CenterContainer/HBoxContainer/TextureRect
onready var joypad_icon_2 = $CenterContainer/HBoxContainer/TextureRect2

func _ready():
	_update_button_for(_get_current_input())
	
	
func _update_button_for(ev: InputEvent) -> void:
	label.hide()
	joypad_icon_1.hide()
	joypad_icon_2.hide()
	
	if PlayerInput.is_joypad_event(ev):
		var img1 = "question"
		var img2 = ""
		
		if ev is InputEventJoypadButton:
			print(ev.button_index)
			if joypad_map.has(ev.button_index):
				img1 = joypad_map.get(ev.button_index)
		elif ev is InputEventJoypadMotion:
			print(str(ev.axis) + ", " + str(ev.axis_value))
			if ev.axis == JOY_AXIS_0 || ev.axis == JOY_AXIS_1:
				img1 = "joystickL_top"
			elif ev.axis == JOY_AXIS_2 || ev.axis == JOY_AXIS_3:
				img1 = "joystickR_top"
			
			if ev.axis_value != 0:
				if ev.axis in [JOY_AXIS_0, JOY_AXIS_2]:
					img2 = "arrowRight" if ev.axis_value > 0 else "arrowLeft"
				elif ev.axis in [JOY_AXIS_1, JOY_AXIS_3]:
					img2 = "arrowUpL" if ev.axis_value > 0 else "arrowDownL" 
			
		_set_joypad_icon(joypad_icon_1, img1)
		_set_joypad_icon(joypad_icon_2, img2)
	else:
		label.text = "?"
		if ev is InputEventKey:
			label.text = OS.get_scancode_string(ev.scancode)
		
		label.show()


func _set_joypad_icon(icon: TextureRect, img: String):
	if img != "":
		icon.texture = load(_get_joypad_icon(img))
		icon.rect_min_size = Vector2(label.rect_size.y, label.rect_size.y)
		icon.show()


func _get_joypad_icon(img: String) -> String:
	return Utils.get_script_path(self) + img + ".png"

func _get_current_input() -> InputEvent:
	var inputs = InputMap.get_action_list(input)
	for i in inputs:
		if joypad and PlayerInput.is_joypad_event(i):
			return i
		if not joypad and not PlayerInput.is_joypad_event(i):
			return i
	return null
