extends Node2D

const checkpoint_scene = preload("res://maps/Checkpoint.tscn")

export var min_checkpoint_size = 100
export var max_checkpoint_size = 200

onready var player_spawner := $PlayerSpawner
onready var space := $Space
onready var path := $Path2D

var laps = 3
var player_checkpoints = {}
var checkpoints = []

var init = false

func _checkpoint_passed(player_num: int) -> void:
	player_checkpoints[player_num] += 1
	
	if player_checkpoints[player_num] >= laps * checkpoints.size():
		Events.emit_signal("game_ended", player_num)
	
	_update_checkpoint_for(player_num)
	

func _update_checkpoint_for(player_num: int) -> void:
	var current_checkpoint = player_checkpoints[player_num] + 1
	var checkpoint = checkpoints[current_checkpoint % checkpoints.size()]
	checkpoint.add_expecting_player(player_num)

func _process(delta):
	if not init:
		_create_race_track()
		
		for player in player_spawner.create_players():
			add_child(player)
			player.global_position = checkpoints[0].global_position
			player.turn(checkpoints[0].direction)
			
			player_checkpoints[player.player_number] = 0
			_update_checkpoint_for(player.player_number)
		
		init = true

func _create_race_track():
	var points = _get_points()
	
	var asteroid_group = space.get_asteriods(points, 300)
	
	for i in range(0, points.size()):
		var point = points[i]
		if not asteroid_group.has(point):
			print("No asteroids for point " + str(point))
			continue
		
		var asteroids = asteroid_group[point]
		
		if asteroids.size() <= 1:
			print("Not enough asteroids to create checkpoint")
			continue
		
		var next_point = points[i + 1 if i != points.size() - 1 else 0]
		var dir: Vector2 = next_point - point
		
		var checkpoint = _set_checkpoint(asteroids, dir, point)
		if not checkpoint:
			print("Could not create checkpoint for " + str(point))

func _set_checkpoint(points: Array, dir: Vector2, point: Vector2) -> Node:
	var line = VectorUtils.find_orthogonal_line(points, dir, point, min_checkpoint_size, max_checkpoint_size)
	if line.size() != 2:
		return null
	
	return _create_checkpoint(line[0], line[1], dir)

func _create_checkpoint(left: Vector2, right: Vector2, dir: Vector2) -> Node:
	var checkpoint = checkpoint_scene.instance()
	add_child(checkpoint)
	
	var center_dir = (right - left) / 2
	checkpoint.global_position = left + center_dir
	checkpoint.set_size(center_dir.length())
	
	var dir_angle = rad2deg(center_dir.angle_to(dir))
	var angle = 90
	if dir_angle < 0:
		angle *= -1
	
	var checkpoint_dir = center_dir.rotated(deg2rad(angle))
	checkpoint.set_direction(checkpoint_dir)
	checkpoint.connect("player_passed", self, "_checkpoint_passed")
	checkpoints.append(checkpoint)
	
	return checkpoint

func _split_objects(objects: Array, linear: LinearEquation) -> Array:
	var left = []
	var right = []
	
	for obj in objects:
		var point = obj.global_position
		if point.y < linear.y(point.x):
			right.append(obj)
		else:
			left.append(obj)
	
	return [left, right]
	
	
func _get_points() -> Array:
	var result = []
	for i in range(0, path.curve.get_point_count()):
		result.append(path.curve.get_point_position(i))
	return result
