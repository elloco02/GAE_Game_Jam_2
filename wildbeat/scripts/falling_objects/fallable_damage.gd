extends Fallable

@export var damage: int = 1

func on_player_entered(player: Player) -> void:
	player.take_damage(damage)
	print("dealing {} damage to player".format(damage))
	queue_free() # Default behavior is to remove the object
