class_name Shield

extends Node2D

@export_subgroup("Shield Settings")
@export var shield_particle: ShieldParticle

@export_subgroup("Sound Effects")
@export var shield_sound: SoundEffectSettings.SOUND_EFFECT_TYPE = SoundEffectSettings.SOUND_EFFECT_TYPE.PLAYER_SHIELDING

var is_active: bool:
	set(value):
		is_active = value
		if shield_particle:
			shield_particle.emitting = value
		if value:
			play_shield_sound()


func deactivate() -> void:
	is_active = false


func activate() -> void:
	is_active = true


func play_shield_sound() -> void:
	AudioManager.create_2d_audio_at_location(global_position, shield_sound)
