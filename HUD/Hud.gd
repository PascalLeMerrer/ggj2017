extends Node

var winner_text
var score_labels = []

func _ready():
	var player_1_score = get_node("LeftScore")
	score_labels.append(player_1_score)
	var player_2_score = get_node("RightScore")
	score_labels.append(player_2_score)
	
	winner_text = get_node("Winner")
	winner_text.hide()
	get_node("Continue").hide()

func victory(player):
	winner_text.set_text("Player " + player + " wins")
	winner_text.show()
	get_node("Continue").show()

func reset_hud():
	winner_text.hide()
	get_node("Continue").hide()

func set_score(player, score):
	score_labels[player].set_text(str(score))
