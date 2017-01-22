var paddles = []

const Ball = preload("res://ball/Ball.tscn")
const MAX_BALLS = 10
var ball_count = 0

var balls = []

func register_paddle(paddle):
	paddles.append(paddle)
	
	
func create_ball(paddle, arena):
	if(balls.size() >= MAX_BALLS):
		return null
		
	var ball = Ball.instance()
	ball.set_name("Ball" + str(ball_count))
	arena.add_child(ball)
	ball.set_owner(arena)
	
	var initial_position = paddle.origin_pos
	if(paddle.x_offset > 0):	
		initial_position.x += paddle.x_offset + 50
	else:
		initial_position.x += paddle.x_offset - 50
	ball.get_node("RigidBody2D").set_pos(initial_position)

	balls.append(ball)
	
	return ball
	
func destroy_ball(ball):
	if ball.is_in_group('balls'):
		balls.erase(ball.get_parent())
		ball.get_parent().queue_free()
	else:
		balls.erase(ball)
		ball.queue_free()
	
func destroy_all_balls():
	for ball in balls:
		ball.queue_free()
	balls.clear()
