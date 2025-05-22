class_name FallableCoin

extends Fallable

@export var points: int = 100

# Player receives score
func on_player_entered(_player: Player) -> void:
	ScoreManager.add_score(points)
	print("Gained ", points, " point(s). Current score: ", ScoreManager.score)
