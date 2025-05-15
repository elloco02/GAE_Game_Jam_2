class_name FallableCoin

extends Fallable

@export var points: int = 1

func on_player_entered(_player: Player) -> void:
	print("Gained ", points, " point(s)")
	queue_free() # Default behavior is to remove the object
