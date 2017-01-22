extends StaticBody2D

var color

func get_color():
	return color
	
func set_color(new_color):
	color = new_color
	
	get_node("Corner/StaticBody2D/Sprite").set_modulate(new_color)
	get_node("GoalCorner/StaticBody2D/Sprite").set_modulate(new_color)
	get_node("GoalLine/StaticBody2D/Sprite").set_modulate(new_color)
	get_node("BorderLine1/StaticBody2D/Sprite").set_modulate(new_color)
	get_node("BorderLine2/StaticBody2D/Sprite").set_modulate(new_color)