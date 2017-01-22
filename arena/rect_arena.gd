extends Node2D

var Color_Generator = preload("res://ColorGenerator.gd").new()

func _ready():
	for border in self.get_children():
		set_random_color(border)
		
		var timer = Timer.new()
		
		timer.set_wait_time(10)
		timer.connect("timeout", self, "set_random_color", [border])
		timer.set_autostart(true)
		timer.set_one_shot(false)
		
		add_child(timer)

func set_random_color(border):
	var current_color = border.get_color()
	
	var new_color = Color_Generator.get_new_random_color(current_color)
	
	border.set_color(new_color)