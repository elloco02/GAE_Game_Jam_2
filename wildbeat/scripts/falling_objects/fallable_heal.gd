class_name FallableHeal

extends Fallable

@export var amount: int = 1

# player receives a heal
func on_player_entered(player: Player) -> void:
	player.heal(self.amount)
	print("heal collected")
	queue_free() # Default behavior is to remove the object
