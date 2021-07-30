extends BlueNoiseWorldGenerator


func get_asteriods(points: Array, boundary_size = 10) -> Dictionary:
	var asteroids_pos = []
	
	for key in _sectors:
		for asteroid in _sectors[key]:
			if asteroid.is_visible_on_screen():
				asteroids_pos.append(asteroid.global_position)
	
	return VectorUtils.find_points_around(asteroids_pos, points, boundary_size)


func is_occupied(global_pos: Vector2, size = 3) -> bool:
	var data = _sectors[_current_sector]
	for asteroid in data:
		var boundary = Rect2(asteroid.global_position, Vector2(size, size))
		if boundary.has_point(global_pos):
			return true
	return false
