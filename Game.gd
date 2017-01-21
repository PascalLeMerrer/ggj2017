const MIDDLE_Y = 450
const victory_condition = 200

var ball_factory = preload("ball/BallFactory.gd").new()

var left_paddle
var right_paddle
var paddle_counter = 0
var game_over = false

var scores = [0, 0]
var hud

func _ready():
	left_paddle = create_paddle("LeftPaddle/KinematicBody2D", 'left', Vector2(100, MIDDLE_Y))
	right_paddle = create_paddle("RightPaddle/KinematicBody2D", 'right', Vector2(1340, MIDDLE_Y))
	
	print("left_paddle=", left_paddle," right_paddle=", right_paddle)
	
	hud = get_node('Hud')
	ball_factory.create_ball(right_paddle, self)
	
	init_goals()
	init_scores()
	
	set_process(true)

func _process(delta):
	if(Input.is_action_pressed("ui_cancel")):
		reset_game()
	
	if(game_over and Input.is_action_pressed("ui_select")):
		game_over = false
		reset_game()

func create_paddle(node_path, position, origin):
	var paddle = get_node(node_path)
	paddle.pad_number = paddle_counter 
	paddle.pad_position = position
	paddle.set_origin(origin)
	ball_factory.register_paddle(paddle)
	paddle_counter += 1
	return paddle

func init_scores():
	hud.set_score(1, 000)
	
func on_goal_hit(ball, goal_position):

	ball_factory.destroy_ball(ball)

	if goal_position == 'left' and increase_score(1, 10):
		ball_factory.create_ball(left_paddle, self)
	elif goal_position == 'right' and increase_score(0, 10):
		ball_factory.create_ball(right_paddle, self)
	else:
		ball_factory.destroy_all_balls()
		hud.victory(goal_position)
		game_over = true

func increase_score(player, points):
	scores[player] += points
	hud.set_score(player, scores[player])
	
	return scores[player] < victory_condition
	
func init_goals():
	get_node("LeftGoal/StaticBody2D").position = 'left'
	get_node("RightGoal/StaticBody2D").position = 'right'

func reset_game():
	left_paddle.go_to_origin()
	right_paddle.go_to_origin()
	ball_factory.destroy_all_balls()
	ball_factory.create_ball(left_paddle, self)
	scores[0] = 0
	hud.set_score(0, 0)
	hud.set_score(1, 0)
	scores[1] = 0
	hud.reset_hud()
