const MIDDLE_Y = 450

var ball_factory = preload("ball/BallFactory.gd").new()

var left_paddle
var right_paddle
var paddle_counter = 0

var scores = [0, 0]
var hud

func _ready():
	left_paddle = create_paddle("LeftPaddle/KinematicBody2D", 'left', Vector2(100, MIDDLE_Y))
	right_paddle = create_paddle("RightPaddle/KinematicBody2D", 'right', Vector2(1340, MIDDLE_Y  + 150))
	hud = get_node('Hud')
	ball_factory.create_ball(left_paddle, self)

	init_goals()
	init_scores()
	
			
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
	
func on_goal_hit(goal_position):
	if(goal_position == 'left'):
		increase_score(1, 10)
	elif(goal_position == 'right'):
		increase_score(0, 10)
	
	
func increase_score(player, points):
	scores[player] += points
	hud.set_score(player, scores[player])
	
func init_goals():
	get_node("LeftGoal/StaticBody2D").position = 'left'
	get_node("RightGoal/StaticBody2D").position = 'right'
