extends Area2D

class_name Checkpoint

signal player_passed(player_num)

onready var collision := $CollisionShape2D
onready var left := $Left
onready var right := $Right

var player_indicators = {}
var expecting_players = []

var enter_pos = {}
var direction: Vector2

func _ready():
	var start_y = -15
	var offset = 10
	var player_count = Globals.player_manager.max_players
	for i in range(0, player_count):
		var color_rect = ColorRect.new()
		color_rect.color = Player.get_player_color(i)
		color_rect.color.a8 = 100
		add_child(color_rect)
		color_rect.rect_min_size = Vector2(5, 5)
		color_rect.set_position(Vector2(0, start_y + (offset * i)))
		player_indicators[i] = color_rect
		color_rect.hide()
	

func add_expecting_player(player_num: int) -> void:
	if expecting_players.has(player_num): return
	expecting_players.append(player_num)
	player_indicators[player_num].show()


func set_size(size: float) -> void:
	var shape = RectangleShape2D.new()
	shape.extents = Vector2(size, 10)
	collision.shape = shape
	left.position.x = -size
	right.position.x = size
	
	for player in player_indicators:
		var indicator = player_indicators[player]
		indicator.rect_min_size.x = size
		indicator.rect_position.x = -size / 2


func set_direction(dir: Vector2) -> void:
	rotation = Vector2.UP.angle_to(dir)
	direction = dir


func _on_Checkpoint_body_entered(body):
	if not body is Player or not expecting_players.has(body.player_number): return
	
	enter_pos[body.player_number] = body.global_position


func _on_Checkpoint_body_exited(body):
	if not body is Player or not enter_pos.has(body.player_number): return
	
	var num = body.player_number
	var expected_dir = Vector2.UP.rotated(rotation)
	var move_dir = enter_pos[num].direction_to(body.global_position)
	
	var angle = abs(rad2deg(move_dir.angle_to(expected_dir)))
	if angle <= 80:
		emit_signal("player_passed", num)
		expecting_players.erase(num)
		player_indicators[num].hide()
	
	enter_pos.erase(num)
