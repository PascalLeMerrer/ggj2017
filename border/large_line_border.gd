extends Node2D


var color

func get_color():
	return color
	
func set_color(new_color):
	color = new_color
	
	get_node("Left/StaticBody2D/Sprite").set_modulate(new_color)
	get_node("FullRight/StaticBody2D/Sprite").set_modulate(new_color)
	get_node("Right/StaticBody2D/Sprite").set_modulate(new_color)
	get_node("FullLeft/StaticBody2D/Sprite").set_modulate(new_color)