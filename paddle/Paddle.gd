extends Node

const MAX_DISTANCE = 256
const DEADZONE = 0.4
const SPEED = 500
const RECALL_SPEED = 150

const LEFT = 'left'
const RIGHT = 'right'
const RADIUS = 36

var origin_pos
var pad_number
var pad_position # should be 'left' or 'right'
var is_vibrating = false
var x_offset

func _ready():
	set_fixed_process(true)

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
	
func set_speed(delta):
	var x_axis_value = Input.get_joy_axis(pad_number, 0)
	var y_axis_value = Input.get_joy_axis(pad_number, 1)
	
	var direction = Vector2(x_axis_value, y_axis_value)
	var motion = get_motion(direction, SPEED, delta)
	var new_pos = get_pos() + motion
	
	if abs(direction.x) < DEADZONE && abs(direction.y) < DEADZONE:
		recall(delta)
	elif (new_pos.distance_to(origin_pos) < MAX_DISTANCE):
		custom_move(motion, direction, SPEED)

	else:
		recall(delta)

func recall(delta):
	var recall_direction = (origin_pos - get_pos())
	var motion = get_motion(recall_direction, RECALL_SPEED, delta)
	var new_pos = get_pos() + motion
	
	if(new_pos.distance_to(origin_pos) > 5):
		custom_move(motion, recall_direction, RECALL_SPEED)

func get_motion(direction, speed, delta):
	return direction.normalized() * speed * delta

#func custom_move(motion, direction, speed):
#	set_pos(get_pos() + motion)

func custom_move(motion, direction, speed):
	motion = move(motion)
	
	if (is_colliding()):
		var n = get_collision_normal()
		motion = n.slide(motion)
		n.slide(direction.normalized() * speed)
		move(motion)

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
