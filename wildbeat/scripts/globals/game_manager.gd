extends Node

func display_time():
	var root = get_tree().get_current_scene()
	print("root:" + str(root))
	var scoreLabel = get_tree().current_scene.get_node("ScoreLabel")
	if scoreLabel:
		scoreLabel.text = "Your score: " + str(ScoreManager.score)
	
