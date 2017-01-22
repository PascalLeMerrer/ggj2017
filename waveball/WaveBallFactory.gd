extends Node

const WaveBall = preload("res://waveball/WaveBall.tscn")
const COOLDOWN_IN_SEC = 10

var waveball_count = 0

var game_root

var cooldown = [0, 0]

func _ready():
	game_root = get_node('/root/Game')
	set_process(true)
	
func _process(delta):
	for i in range(cooldown.size()):
		if cooldown[i] > 0:
			cooldown[i] = cooldown[i] - delta
			# TODO display status
	process_paddle(0, "LeftPaddle")		
	process_paddle(1, "RightPaddle")

	
func process_paddle(paddle_id, paddle_name):
	var power_pressed = Input.is_action_pressed('power_' + str(paddle_id))
	if power_pressed and cooldown[paddle_id] <= 0:
		var paddle = game_root.get_node(paddle_name + "/KinematicBody2D")
		create_waveball(paddle)
		cooldown[paddle_id] = COOLDOWN_IN_SEC

func create_waveball(paddle):
		
	var waveball = WaveBall.instance()
	waveball.set_name("WaveBall" + str(waveball_count))
	game_root.add_child(waveball)
	waveball.set_owner(game_root)
	
	var initial_position = paddle.get_pos()	
	initial_position.x += paddle.x_offset
	
	if(paddle.pad_position == 'left'):
		waveball.start(initial_position, Vector2(1, 1))
	else:
		waveball.start(initial_position, Vector2(-1, 1))
		
	return waveball



