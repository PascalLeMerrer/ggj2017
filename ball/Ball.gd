extends RigidBody2D

var game_root
var left_goal
var right_goal

func _ready():
	set_contact_monitor(true)
	set_max_contacts_reported(5)

	game_root = get_node("/root/Game")
	left_goal = game_root.get_node("LeftGoal/StaticBody2D")
	right_goal = game_root.get_node("RightGoal/StaticBody2D")
	set_fixed_process(true)
#	
func _fixed_process(delta):
	set_linear_damp(0.999) 
	
func _on_RigidBody2D_body_enter( body ):
	if(body extends StaticBody2D):
		process_collision_with_goal(body, left_goal)
		process_collision_with_goal(body, right_goal)
		
func process_collision_with_goal(collider, goal):
	if (collider == goal):
		print(goal.position + " hit") 
		game_root.on_goal_hit(self, goal.position)