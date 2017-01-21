extends Node

var paddles = []

var ball = preload("res://ball/Ball.tscn")
var ball_count = 0

func _ready():
	pass
	
func register_paddle(paddle):
	paddles.append(paddle)
	
func create_ball(paddle):
	var ball = ball.instance()
	ball.set_name("Ball" + str(ball_count))
	add_child(ball)
	ball.set_owner(self)
	#ball.set_pos(get_pos() + Vector2(0, -92))
	
