class_name FallableCoin

extends Fallable

@export var points: int = 100

func on_player_entered(_player: Player) -> void:
	AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.COLLECT_ITEM)
	ScoreManager.add_score(points)
	print("Gained ", points, " point(s). Current score: ", ScoreManager.score)
	queue_free() # Default behavior is to remove the object
