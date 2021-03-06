const MIDDLE_Y = 450
const victory_condition = 100

var ball_factory = preload("ball/BallFactory.gd").new()

var left_paddle
var right_paddle
var paddle_counter = 0
var game_over = false

var scores = [0, 0]
var hud

var timers = []

func _ready():

	left_paddle = create_paddle("LeftPaddle/KinematicBody2D", 'left', Vector2(100, MIDDLE_Y))
	right_paddle = create_paddle("RightPaddle/KinematicBody2D", 'right', Vector2(1340, MIDDLE_Y))

	hud = get_node('Hud')
	spawn_new_ball('left')

	init_goals()
	init_scores()

	set_process(true)

func _process(delta):
	if(Input.is_action_pressed("ui_reset")):
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
	hud.set_score(0, 0)
	hud.set_score(1, 0)

func on_goal_hit(ball, goal_position):

	ball_factory.destroy_ball(ball)

	var spawn_timer = Timer.new()
	spawn_timer.set_wait_time(2)
	spawn_timer.connect("timeout", self, "spawn_new_ball_with_timer", [goal_position, spawn_timer])
	timers.append(spawn_timer)

	if goal_position == 'left':
		increase_score(1, 10)
		if has_won(1):
			finish_game('right')
		else:
			add_child(spawn_timer)
			spawn_timer.start()
	elif goal_position == 'right':
		increase_score(0, 10)
		if has_won(0):
			finish_game('left')
		else:
			add_child(spawn_timer)
			spawn_timer.start()

func finish_game(winner):
		ball_factory.destroy_all_balls()
		hud.victory(winner)
		game_over = true
		get_node("FinalTheme").stop()
		get_node("VictoryTheme").play()

func increase_score(player, points):
	var previous_max_score = max(scores[0], scores[1])
	scores[player] += points
	var new_max_score = max(scores[0], scores[1])

	var leader_change = new_max_score > previous_max_score

	if leader_change && new_max_score >= (victory_condition / 2) && previous_max_score < (victory_condition / 2):
		get_node("CoolTheme").stop()
		get_node("ChangeTheme").play('BUT')
		get_node("MediumTheme").play()
	elif leader_change && new_max_score == victory_condition - 10:
		get_node("FinalTheme").play()
		get_node("ChangeTheme").play('BUT')
		get_node("MediumTheme").stop()

	hud.set_score(player, scores[player])

func has_won(player):
	return scores[player] >= victory_condition

func init_goals():
	get_node("LeftGoal/StaticBody2D").position = 'left'
	get_node("RightGoal/StaticBody2D").position = 'right'

func reset_game():
	get_node("VictoryTheme").stop()
	get_node("MediumTheme").stop()
	get_node("FinalTheme").stop()
	get_node("CoolTheme").play()

	left_paddle.go_to_origin()
	right_paddle.go_to_origin()
	ball_factory.destroy_all_balls()
	ball_factory.create_ball(left_paddle, self)

	scores[0] = 0
	hud.set_score(0, 0)
	hud.set_score(1, 0)
	scores[1] = 0
	hud.reset_hud()

	for timer in timers:
		if timer != null:
			timer.queue_free()
	timers.clear()

func spawn_new_ball(position):

	if position == 'left':
		ball_factory.create_ball(left_paddle, self)
	elif position == 'right':
		ball_factory.create_ball(right_paddle, self)

func spawn_new_ball_with_timer(position, timer):
	if !game_over:
		spawn_new_ball(position)
	timers.erase(timer)
	timer.queue_free()
