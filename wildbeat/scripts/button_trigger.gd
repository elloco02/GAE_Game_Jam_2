extends Button

@onready var click_button_sound: AudioStreamPlayer2D = $click_button_sound

@export var scene_path: String

func _on_pressed() -> void:
	click_button_sound.play()
	if self.name == "Quit":
		get_tree().quit()
	print("pressed button: " + str(self.name))
	SceneManager.change_scene_to(scene_path)
