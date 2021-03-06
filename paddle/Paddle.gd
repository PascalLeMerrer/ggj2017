extends KinematicBody2D

var Color_Generator = preload("res://ColorGenerator.gd").new()

const MAX_DISTANCE = 256
const DEADZONE = 0.4
const SPEED = 1500

const LEFT = 'left'
const RIGHT = 'right'
const RADIUS = 36

var origin_pos
var pad_number
var pad_position # should be 'left' or 'right'
var is_vibrating = false
var x_offset

var current_color

func _ready():
	add_to_group('paddles')
	set_fixed_process(true)
	current_color = Color_Generator.get_random_color()
	get_node("Sprite").set_modulate(current_color)

func set_origin(position):
	origin_pos = position
	
	if (pad_position == LEFT):
		x_offset = RADIUS
	elif (pad_position == RIGHT):
		x_offset = -RADIUS
		
	origin_pos.x += x_offset
	go_to_origin()
		
func go_to_origin():
	set_pos(origin_pos)
		
func _fixed_process(delta):
	set_speed(delta)
	prevent_exiting_arena()
	vibrate()
	var new_color = Color_Generator.select_color(pad_number, current_color)
	if new_color != null:
		current_color = new_color
		get_node("Sprite").set_modulate(new_color)
	
func set_speed(delta):
	var x_axis_value = Input.get_joy_axis(pad_number, 0)
	var y_axis_value = Input.get_joy_axis(pad_number, 1)
	
	var direction = Vector2(x_axis_value, y_axis_value)
	
	var new_pos = get_new_pos(direction, SPEED, delta)
	
	if direction.length() > DEADZONE and (new_pos.distance_to(origin_pos) < MAX_DISTANCE):
		set_pos(new_pos)
	else:
		revert_motion()

func get_new_pos(direction, speed, delta):
	return get_pos() + direction.normalized() * speed * delta
	
func prevent_exiting_arena():
	var current_position = get_pos()
	var viewport_size = get_viewport_rect().size
	var min_x = RADIUS
	var max_x = viewport_size.x - RADIUS
	
	if(current_position.x < min_x):
		current_position.x = min_x
		set_pos(current_position)
	if(current_position.x > max_x):
		current_position.x = max_x
		set_pos(current_position)
	
func vibrate():
	if get_pos().distance_to(origin_pos) > (MAX_DISTANCE - 15):
		Input.start_joy_vibration(pad_number, 1, 1)
		is_vibrating = true
		
	elif is_vibrating:
		Input.stop_joy_vibration(pad_number)
		is_vibrating = false
