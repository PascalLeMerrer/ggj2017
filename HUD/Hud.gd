extends Node

var winner_text
var scorer_text
var score_labels = []

func _ready():
	var player_1_score = get_node("LeftScore")
	score_labels.append(player_1_score)
	var player_2_score = get_node("RightScore")
	score_labels.append(player_2_score)
	
	winner_text = get_node("Winner")
	winner_text.hide()
	scorer_text = get_node("Scorer")
	scorer_text.hide()
	get_node("Continue").hide()

func victory(player):
	winner_text.set_text("Player " + player + " wins")
	winner_text.show()
	get_node("Continue").show()

func reset_hud():
	winner_text.hide()
	get_node("Continue").hide()

func set_score(player, score):
	var who_scores = ""
	if score != 0 and player == 0:
		who_scores = "Player left scores!!!"
	elif score != 0 and player == 1:
		who_scores = "Player right scores!!!"
	
	score_labels[player].set_text(str(score))
	scorer_text.set_text(who_scores)
	scorer_text.show()
	get_node("ScorerTimeout").start()

func _on_ScorerTimeout_timeout():
	scorer_text.hide()
