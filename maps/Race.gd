extends Node2D

const checkpoint_scene = preload("res://maps/Checkpoint.tscn")

export var min_checkpoint_size = 100
export var max_checkpoint_size = 200

onready var player_spawner := $PlayerSpawner
onready var space := $Space
onready var path := $Path2D

var init = false

func _ready():
	for player in player_spawner.create_players():
		add_child(player)

func _process(delta):
	if not init:
		_create_race_track()
		init = true

func _create_race_track():
	var points = _get_points()
	points.pop_back() # Last one not needed, it should be very close to the start
	
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
			print("Could not create checkpoint for " + str(point) + "with " + str(asteroids))
		else:
			print("Created checkpoint for " + str(point) + " with " + str(asteroids))

func _set_checkpoint(points: Array, dir: Vector2, point: Vector2) -> Node:
	var line = VectorUtils.find_orthogonal_line(points, dir, point, min_checkpoint_size, max_checkpoint_size)
	if line.size() != 2:
		return null
	
	return _create_checkpoint(line[0], line[1])

func _create_checkpoint(left: Vector2, right: Vector2) -> Node:
	var checkpoint = checkpoint_scene.instance()
	add_child(checkpoint)
#	checkpoint.set_size(distance / 2)
	
	checkpoint.global_position = left
	
	var c2 = checkpoint_scene.instance()
	add_child(c2)
	c2.global_position = right
				
#	var center_dir = left_pos.direction_to(right_pos) / 2
#	checkpoint.global_position = left_pos + center_dir
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
