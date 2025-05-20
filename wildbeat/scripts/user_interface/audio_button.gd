class_name AudioButton

extends Button

@export var scene: PackedScene
@export var to_main_menu: bool = false
@export var reset_score: bool = false
@export var to_game: bool = false

func _ready() -> void:
	self.pressed.connect(handle_pressed)


func handle_pressed() -> void:
	AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.UI_BUTTON_PRESSED)
	button_pressed()
	if reset_score:
		ScoreManager.reset_score()

	if to_main_menu:
		SceneManager.change_scene_to(load("res://scenes/menu/main_menu.tscn"))
	elif scene:
		SceneManager.change_scene_to(scene, to_game)


func button_pressed() -> void:
	return
