const MIDDLE_Y = 450

var ball_factory = preload("ball/BallFactory.gd").new()

var left_paddle
var right_paddle
var paddle_counter = 0

func _ready():
	left_paddle = create_paddle("LeftPaddle/KinematicBody2D", 'left', Vector2(0, MIDDLE_Y))
	right_paddle = create_paddle("RightPaddle/KinematicBody2D", 'right', Vector2(1440, MIDDLE_Y))
	ball_factory.create_ball(left_paddle, self)
	
func create_paddle(node_path, position, origin):
	var paddle = get_node(node_path)
	paddle.pad_number = paddle_counter 
	paddle.pad_position = position
	paddle.set_origin(origin)
	ball_factory.register_paddle(paddle)
	paddle_counter += 1
	return paddle

func init_scores():
	get_node("Hud").set_score(1, 999)