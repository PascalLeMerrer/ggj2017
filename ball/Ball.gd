extends RigidBody2D

var ShockWave = preload("res://shockwave/shockwave.tscn")

const IDLE_SPEED = 2
const FRAMES_BETWEEN_SPAWN = 100
const LINEAR_DAMPING = 0.99
const SHRINK_FACTOR = 0.9
const GROWTH_FACTOR = 1.1
const MIN_SIZE = 0
const INITIAL_SIZE = 2
const MAX_SIZE = 4
const ACCELERATION = 2
const MAX_SPEED = 3000

var game_root
var left_goal
var right_goal

var idle_counter = 0
var has_moved = false
var first_idle_time = true
var is_out = false

var last_paddle_hit
var color
var current_size = INITIAL_SIZE

var shockwave

func _ready():
	add_to_group('balls')
	
	idle_counter = 0
	has_moved = false
	first_idle_time = true
	is_out = false
	set_contact_monitor(true)
	set_max_contacts_reported(5)

	game_root = get_node("/root/Game")
	left_goal = game_root.get_node("LeftGoal/StaticBody2D")
	right_goal = game_root.get_node("RightGoal/StaticBody2D")
	set_fixed_process(true)
	set_linear_damp(LINEAR_DAMPING)
	
func _fixed_process(delta):
	var velocity = get_linear_velocity()
	var is_idle = velocity.x < IDLE_SPEED and velocity.y < IDLE_SPEED
	if !is_idle:
		has_moved = true
	if is_idle and has_moved:
		idle_counter += 1
	else:
		idle_counter = 0
		
	if idle_counter > FRAMES_BETWEEN_SPAWN and first_idle_time and !is_out:
		spawn_new_ball()
		first_idle_time = false

func spawn_new_ball():
	if last_paddle_hit == 'LeftPaddle':
		game_root.spawn_new_ball('right')
	else:
		game_root.spawn_new_ball('left')
	
func _on_RigidBody2D_body_enter( body ):
	var explosion_just_created = false
	
	if body.is_in_group('borders'):
		process_collision_with_border(body)
		
	elif body.is_in_group('goals'):
		process_collision_with_goal(body, left_goal)
		process_collision_with_goal(body, right_goal)
			
	elif body.is_in_group('paddles'):
		process_collision_with_paddle(body)
		
		randomize()
		if randi() % 5 == 0 and shockwave == null:
			print('load shockwave')
			shockwave = ShockWave.instance()
			explosion_just_created = true
	
	if !explosion_just_created and !body.is_in_group('goals') and shockwave != null:
		print('explode')
		var game = get_node("/root/Game")
		game.add_child(shockwave)
		shockwave.set_pos(get_global_pos())
		shockwave.explode()
		shockwave = null

func process_collision_with_goal(collider, goal):
	if (collider == goal):
		is_out = true
		game_root.on_goal_hit(self, goal.position)
		return true
	return false
	
func process_collision_with_border(border):
	var wall_color = border.get_color()
	if wall_color == color and current_size >= MIN_SIZE:
		current_size -= 1
		change_scale(Vector2(SHRINK_FACTOR, SHRINK_FACTOR))
		accelerate()

	elif current_size <= MAX_SIZE:
		current_size += 1
		change_scale(Vector2(GROWTH_FACTOR, GROWTH_FACTOR))
		
func change_scale(ratio):
	get_node("Sprite").scale(ratio)
	get_node("CollisionShape2D").scale(ratio)	

	
func process_collision_with_paddle(paddle):
	last_paddle_hit = paddle.get_parent().get_name()
	color = paddle.current_color
	get_node("Sprite").set_modulate(color)
	
func accelerate():
	var new_velocity = get_linear_velocity() * ACCELERATION
	
	if new_velocity.length() < MAX_SPEED:
		set_linear_velocity(new_velocity)