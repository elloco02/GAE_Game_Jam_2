extends Button

@export var scene_path: String

func _on_pressed() -> void:
	if self.name == "Quit":
		get_tree().quit()
	if self.name == "Submit":
		var username_input = get_node("../UsernameInput") as LineEdit
		var username = username_input.text
		ScoreManager.save_highscore(username)
	print("pressed button: " + str(self.name))
	SceneManager.change_scene_to(scene_path)
	ScoreManager.reset_score()
