extends "ball/ball_factory.gd"

var left_pad
var right_pad
var paddle_counter = 0

func _ready():
	left_pad = create_paddle("LeftPaddle/KinematicBody2D", 'left', Vector2(0, 300))
	right_pad = create_paddle("RightPaddle/KinematicBody2D", 'right', Vector2(1024, 300))
	

func create_paddle(node_path, position, origin):
	var paddle = get_node(node_path)
	paddle.pad_number = paddle_counter 
	paddle.pad_position = position
	paddle.set_origin(origin)
	register_paddle(paddle)
	paddle_counter += 1