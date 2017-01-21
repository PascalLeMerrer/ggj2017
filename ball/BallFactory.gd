var paddles = []

const Ball = preload("res://ball/Ball.tscn")
var ball_count = 0

func register_paddle(paddle):
	paddles.append(paddle)
	
func create_ball(paddle, arena):
	var ball = Ball.instance()
	ball.set_name("Ball" + str(ball_count))
	arena.add_child(ball)
	ball.set_owner(arena)
	
	var initial_position = paddle.get_pos()
	initial_position.x += paddle.x_offset
	ball.get_node("RigidBody2D").set_pos(initial_position)
	return ball
	