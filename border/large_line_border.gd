extends StaticBody2D

var color

func _ready():
	add_to_group('borders')
	
func get_color():
	return color
	
func set_color(new_color):
	color = new_color
	# TODO refactor using a base class + an array of border names
	get_node("Left").set_modulate(new_color)
	get_node("FullRight").set_modulate(new_color)
	get_node("Right").set_modulate(new_color)
	get_node("FullLeft").set_modulate(new_color)