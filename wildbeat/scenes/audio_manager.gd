extends Node

var sound_effect_dict = {}

@export var sound_effect_settings : Array[SoundEffectSettings]
@export var bla : Array[String] = ["312", "132"]

func _ready() -> void:
	for sound_effect_setting : SoundEffectSettings in sound_effect_settings:
		sound_effect_dict[sound_effect_setting.type] = sound_effect_setting
		print("making ready")


func create_2d_audio_at_location(location, type : SoundEffectSettings.SOUND_EFFECT_TYPE):
	print("playing sound")
	if sound_effect_dict.has(type):
		var sound_effect_setting : SoundEffectSettings = sound_effect_dict[type]
		var new_2D_audio = AudioStreamPlayer2D.new()
		add_child(new_2D_audio)
		
		new_2D_audio.position = location
		new_2D_audio.stream = sound_effect_setting.sound_effect
		new_2D_audio.volume_db = sound_effect_setting.volume
		new_2D_audio.finished.connect(new_2D_audio.queue_free)
		
		new_2D_audio.play()
	else:
		push_error("Audio Manager Failed to find setting for type: ", type)
	
