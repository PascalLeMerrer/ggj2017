extends Area2D

const MAX_RADIUS = 500
const POWER = 800
const PROPAGATION = 400

var exploding = false
var colapsing = false
var current_radius = 1
var shockwave

func _ready():
	shockwave = get_node("CollisionShape2D")
	set_fixed_process(true)
	#for debug: explode()

func explode():
	exploding = true
	get_node("SamplePlayer2D").play("Shockwave")
	get_node("Sprite").show()
	get_node("Sprite/AnimationPlayer").play("exploding")

func _fixed_process(delta):
	if exploding:
		current_radius += delta * PROPAGATION
	
		if current_radius < MAX_RADIUS:
			shockwave.get_shape().set_radius(current_radius)
		else:
			exploding = false;
			shockwave.get_shape().set_radius(0)
			var anim = get_node("Sprite/AnimationPlayer")
			
			anim.play("colapsing")
			anim.connect("finished", self, "on_colapse_finished")

func on_colapse_finished():
	queue_free()

func _on_Area2D_body_enter( body ):
	if body.is_in_group("balls"):
		var shockwave_center = get_global_pos()
		var ball_center = body.get_global_pos()
		
		var impulse = ball_center - shockwave_center
		
		#you want som' rotation ? body.apply_impulse(shockwave_center, impulse) 
		body.apply_impulse(Vector2(0,0), impulse.normalized() * POWER)