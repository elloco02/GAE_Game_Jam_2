extends Node

var score = 0
var highscores = []

func add_score(points: int) -> void:
	score += points

func reset_score() -> void:
	score = 0

func save_highscore(username: String) -> void:
	if username.strip_edges() == "":
		print("Username cannot be empty!")
		return
	
	var score_data = {
		"username": username,
		"score": score
	}
	
	highscores = load_highscores()
	highscores.append(score_data)
	highscores.sort_custom(func(a, b): return a["score"] > b["score"])
	
	var file = FileAccess.open("user://highscores.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(highscores))
	print("Saved highscore for ", username, " with score ", score)

func load_highscores() -> Array:
	if FileAccess.file_exists("user://highscores.json"):
		var file = FileAccess.open("user://highscores.json", FileAccess.READ)
		var content = file.get_as_text()
		var loaded_scores = JSON.parse_string(content)
		if loaded_scores is Array:
			return loaded_scores
	
	return []
