extends Button

@export var scene_path: String

func _on_pressed() -> void:
	if self.name == "Quit":
		get_tree().quit()
	print("pressed button: " + str(self.name))
	SceneManager.change_scene_to(scene_path)
