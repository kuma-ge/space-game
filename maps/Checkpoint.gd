extends Area2D

signal player_passed(player_num)

onready var collision := $CollisionShape2D

var expecting_players = []

var enter_pos = {}
var direction: Vector2

func add_expecting_player(player_num: int) -> void:
	if expecting_players.has(player_num): return
	expecting_players.append(player_num)


func set_size(size: float) -> void:
	var shape = RectangleShape2D.new()
	shape.extents = Vector2(size, 10)
	collision.shape = shape


func set_direction(dir: Vector2) -> void:
	rotation = Vector2.UP.angle_to(dir)
	direction = dir


func _on_Checkpoint_body_entered(body):
	if not body is Player or not expecting_players.has(body.player_number): return
	
	enter_pos[body.player_number] = body.global_position


func _on_Checkpoint_body_exited(body):
	if not body is Player or not enter_pos.has(body.player_number): return
	
	var expected_dir = Vector2.UP.rotated(rotation)
	var move_dir = enter_pos[body.player_number].direction_to(body.global_position)
	
	var angle = abs(rad2deg(move_dir.angle_to(expected_dir)))
	if angle <= 80:
		emit_signal("player_passed", body.player_number)
		expecting_players.erase(body.player_number)
	
	enter_pos.erase(body.player_number)
