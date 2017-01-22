extends Node2D

const INCREMENT = 2
const MIN_VALUE = -180
const MAX_VALUE = 180
const SPEED = Vector2(200, 100)

var is_started = false
var angle = MIN_VALUE

var direction #Vector2

var body

func _ready():
	body = get_node("KinematicBody2D")
	set_fixed_process(true)
	
func start(initial_position, new_direction):
	body.set_pos(initial_position)
	direction = new_direction
	is_started = true

func _fixed_process(delta):
	if !is_started:
		return true
		
	angle += INCREMENT
	if(angle > MAX_VALUE):
		angle = MIN_VALUE
	var sinusoidal_value = sin(deg2rad(angle))
	
	var new_pos = body.get_pos()
	new_pos.x += (direction.x * SPEED.x * delta)
	new_pos.y += (direction.y * sinusoidal_value * SPEED.y * delta)
	
	body.set_pos(new_pos)
	
	if(body.is_colliding()):
		var collider = get_collider()
		get_node("/root/Game/Hud").set_debug_text(collider)
		if collider.is_in_group('borders'):
			queue_free()
		
			