extends StaticBody2D

var color

func _ready():
	add_to_group('borders')
	
func get_color():
	return color
	
func set_color(new_color):
	color = new_color
	
	# TODO refactor using a base class + an array of border names
	get_node("Corner").set_modulate(new_color)
	get_node("GoalCorner").set_modulate(new_color)
	get_node("GoalBorder").set_modulate(new_color)
	get_node("BorderLine1").set_modulate(new_color)
	get_node("BorderLine2").set_modulate(new_color)