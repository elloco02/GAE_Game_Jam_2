class_name FallableHeal

extends Fallable

@export var amount: int = 1

# Player receives healing
func on_player_entered(player: Player) -> void:
	player.heal(self.amount)
	print("heal collected")
