extends RigidBody2D

func _ready():
	set_contact_monitor(true)
	set_max_contacts_reported(5)

func _on_RigidBody2D_body_enter( body ):

	if(body extends StaticBody2D and body.is_goal()):
		print("goal was hit")
		queue_free()

		
