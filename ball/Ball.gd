extends RigidBody2D

const IDLE_SPEED = 2
const FRAMES_BETWEEN_SPAWN = 120
const LINEAR_DAMPING = 0.99

var game_root
var left_goal
var right_goal
var initial_position

var idle_counter = 0
var has_moved = false
var first_idle_time = true

func _ready():
	set_contact_monitor(true)
	set_max_contacts_reported(5)

	game_root = get_node("/root/Game")
	left_goal = game_root.get_node("LeftGoal/StaticBody2D")
	right_goal = game_root.get_node("RightGoal/StaticBody2D")
	set_fixed_process(true)
	set_linear_damp(LINEAR_DAMPING)
	#	
func _fixed_process(delta):
	var velocity = get_linear_velocity()
	var is_idle = velocity.x < IDLE_SPEED and velocity.y < IDLE_SPEED
	if !is_idle:
		has_moved = true
	if is_idle and has_moved:
		idle_counter += 1
	else:
		idle_counter = 0
		
	if idle_counter > FRAMES_BETWEEN_SPAWN and first_idle_time:
		game_root.spawn_new_ball('left') 
		first_idle_time = false

	
func _on_RigidBody2D_body_enter( body ):
	if(body extends StaticBody2D):
		process_collision_with_goal(body, left_goal)
		process_collision_with_goal(body, right_goal)
		
func process_collision_with_goal(collider, goal):
	if (collider == goal):
		game_root.on_goal_hit(self, goal.position)