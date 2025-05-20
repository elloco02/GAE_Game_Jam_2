extends AudioButton

@onready var username_input: LineEdit = $"../UsernameInput"

func button_pressed() -> void:
	var username = username_input.text
	ScoreManager.save_highscore(username)
