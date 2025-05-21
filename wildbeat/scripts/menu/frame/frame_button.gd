class_name FrameButton
extends Button

@export var frame : Frame

func _ready() -> void:
	# frame.show()
	frame.hide()

func _on_pressed() -> void:
	print("Pressed")
	AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.UI_BUTTON_PRESSED)
	frame.show()
