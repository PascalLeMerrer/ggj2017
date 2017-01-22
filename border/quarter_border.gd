extends StaticBody2D

var color

func get_color():
	return color
	
func set_color(new_color):
	color = new_color
	
	get_node("Corner").set_modulate(new_color)
	get_node("GoalCorner").set_modulate(new_color)
	get_node("GoalBorder").set_modulate(new_color)
	get_node("BorderLine1").set_modulate(new_color)
	get_node("BorderLine2").set_modulate(new_color)