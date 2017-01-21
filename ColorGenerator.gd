const colors = [
	Color(0.66, 0.05, 1),
	Color(0.45, 1, 0),
	Color(1, 1, 0),
	Color(1, 0, 0.3)
]

func get_random_color():
	randomize()
	return colors[randi() % 3]
