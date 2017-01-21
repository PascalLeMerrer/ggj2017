extends Node

var score_labels = []

func _ready():
	score_labels.append(get_node("LeftScore"))
	score_labels.append(get_node("RightScore"))
	
func set_score(player, score):
	score_labels[player].set_text(score)
