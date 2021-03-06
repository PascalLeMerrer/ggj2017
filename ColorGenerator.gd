const colors = [
	Color("54E7FE"),
	Color("8A65B7"),
	Color("FF353D"),
	Color("FF8A27"),
	Color("FFFF00")
]

var gamepad_status = {
	"previous_color_gamepad_0": false,
	"previous_color_gamepad_1": false,
	"next_color_gamepad_0": false,
	"next_color_gamepad_1": false
}

func get_random_color():
	randomize()
	return colors[randi() % 3]

func get_new_random_color(current_color):
	var new_color = get_random_color()
	while(new_color == current_color):
		new_color = get_random_color()
	return new_color

func get_next_color(current_color):
	var current_index = colors.find(current_color)
	var next_index = (current_index + 1) % colors.size()
	return colors[next_index]

func get_previous_color(current_color):
	var current_index = colors.find(current_color)
	var next_index = (current_index - 1)
	if next_index < 0:
		next_index = colors.size() - 1
	return colors[next_index]
			
func select_color(game_pad_index, current_color):
	var left_button_id = "previous_color_gamepad_" + str(game_pad_index)
	if Input.is_action_pressed(left_button_id):
		if !gamepad_status[left_button_id]:
			gamepad_status[left_button_id] = true
			return get_previous_color(current_color)
	else:
		gamepad_status[left_button_id] = false
		
	var right_button_id = "next_color_gamepad_" + str(game_pad_index)
	if Input.is_action_pressed(right_button_id):
		if !gamepad_status[right_button_id]:
			gamepad_status[right_button_id] = true
			return get_next_color(current_color)
	else:
		gamepad_status[right_button_id] = false
	return null
