extends Node

var score_labels = []

func _ready():
	var player_1_score = get_node("LeftScore")
	score_labels.append(player_1_score)
	var player_2_score = get_node("RightScore")
	score_labels.append(player_2_score)
	
func set_score(player, score):
	score_labels[player].set_text(str(score))
