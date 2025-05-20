class_name FallableShield

extends Fallable

# player receives a shield that protects from damage
func on_player_entered(player: Player) -> void:
	AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.PLAYER_SHIELDING)
	player.activate_shield()
	print("shield collected")
