extends UnitTest

var manager: PlayerManager

func before_each():
	manager = autofree(PlayerManager.new())
	watch_signals(manager)

func test_add_players():
	manager.add_player(press_key("ui_accept"))
	assert_signal_emitted_with_parameters(manager, "player_added", [{"device": 0, "joypad": false}, 1])
	
	manager.add_player(press_key("ui_accept"))
	assert_signal_emit_count(manager, "player_added", 1)
	
	manager.add_player(joypad_button_event(JOY_SONY_X))
	assert_signal_emitted_with_parameters(manager, "player_added", [{"device": 0, "joypad": true}, 2])
	
	manager.add_player(joypad_button_event(JOY_SONY_X))
	assert_signal_emit_count(manager, "player_added", 2)

func test_add_max_players():
	manager.max_players = 1
	manager.add_player(press_key("ui_accept"))
	assert_signal_emit_count(manager, "player_added", 1)
	
	manager.add_player(joypad_button_event(JOY_SONY_X))
	assert_signal_emit_count(manager, "player_added", 1)
