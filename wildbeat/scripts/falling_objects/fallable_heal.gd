class_name FallableHeal

extends Fallable

@export var amount: int = 1

# player receives a heal
func on_player_entered(player: Player) -> void:
	AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.PLAYER_HEAL)
	player.heal(self.amount)
	print("heal collected")
