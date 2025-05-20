class_name Health

extends Node2D

@export_subgroup("Health Settings")
@export var max_health: int = 3

@export_subgroup("Shield")
@export var shield: Shield

@export_subgroup("Particles")
@export var heal_particle: HealCollectParticle

@export_subgroup("Sound Effects")
@export var heal_sound: SoundEffectSettings.SOUND_EFFECT_TYPE = SoundEffectSettings.SOUND_EFFECT_TYPE.PLAYER_HEAL
@export var damage_sound: SoundEffectSettings.SOUND_EFFECT_TYPE = SoundEffectSettings.SOUND_EFFECT_TYPE.PLAYER_DAMAGE
@export var death_sound: SoundEffectSettings.SOUND_EFFECT_TYPE = SoundEffectSettings.SOUND_EFFECT_TYPE.PLAYER_DIES


signal health_changed(new_health: int)
signal died

var current_health: int:
	set(value):
		current_health = value
		health_changed.emit(current_health)


func _ready() -> void:
	current_health = max_health


func damage(attack: int = 1) -> void:
	if shield and shield.is_active:
		shield.deactivate()
	else:
		current_health -= attack
		if current_health <= 0:
			died.emit()
			play_death_sound()
		else:
			play_damage_sound()


func heal(amount: int = 1) -> void:
	if current_health == max_health:
		return
	elif max_health < current_health + amount:
		current_health = max_health
	else:
		current_health += amount
	play_heal_sound()
	if heal_particle:
		heal_particle.emitting = true


func play_heal_sound() -> void:
	AudioManager.create_2d_audio_at_location(global_position, heal_sound)


func play_damage_sound() -> void:
	AudioManager.create_2d_audio_at_location(global_position, damage_sound)


func play_death_sound() -> void:
	AudioManager.create_2d_audio_at_location(global_position, death_sound)
