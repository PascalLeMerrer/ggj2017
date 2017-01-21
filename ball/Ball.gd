extends RigidBody2D

func _ready():
	set_contact_monitor(true)
	set_max_contacts_reported(5)

func _on_RigidBody2D_body_enter( body ):

	var left_goal = get_node("/root/Game/LeftGoal")
	var right_goal = get_node("/root/Game/LeftGoal")

	if(body == left_goal or body == right_goal):
		print("goal was hit")
		queue_free()