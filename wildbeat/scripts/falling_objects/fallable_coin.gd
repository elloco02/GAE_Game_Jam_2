class_name FallableCoin

extends Fallable

@export var points: int = 100

func on_player_entered(_player: Player) -> void:
	ScoreManager.score += 100
	print("Gained ", points, " point(s). Current score: ", ScoreManager.score)
	queue_free() # Default behavior is to remove the object
