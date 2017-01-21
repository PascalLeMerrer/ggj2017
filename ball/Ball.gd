extends RigidBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_contact_monitor(true)
	set_max_contacts_reported(5)
	set_process(true)
	print("started")


func _process(delta):
	if( get_colliding_bodies().size() > 0):
		print ("Collision with ", get_colliding_bodies() ) 

func _on_RigidBody2D_body_enter( body ):
	print("collide with", body)
	if(body extends StaticBody2D and body.is_goal()):
		print("goal was hit")
		queue_free()

		
