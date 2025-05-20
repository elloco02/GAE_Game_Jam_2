class_name AudioButton

extends Button

@export var scene: PackedScene
@export var reset_score: bool = false

func _ready() -> void:
	self.pressed.connect(handle_pressed)


func handle_pressed() -> void:
	AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.UI_BUTTON_PRESSED)
	button_pressed()
	if reset_score:
		ScoreManager.reset_score()

	if scene:
		SceneManager.change_scene_to(scene)


func button_pressed() -> void:
	return
