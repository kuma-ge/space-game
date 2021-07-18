extends Focusable

"""
Control that a single player input can focus and control
"""

class_name PlayerFocus

var input: PlayerInput

func _unhandled_input(event):
	if is_focused and _can_handle_event(event):
		var focus_node = null
		
		if event.is_action("ui_up"):
			focus_node = focus_neighbour_top
		elif event.is_action("ui_down"):
			focus_node = focus_neighbour_bottom
		elif event.is_action("ui_left"):
			focus_node = focus_neighbour_left
		elif event.is_action("ui_right"):
			focus_node = focus_neighbour_bottom


func _can_handle_event(event: InputEvent) -> bool:
	return is_focused and input and input.is_player_event(event)
