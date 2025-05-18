class_name FallableShield

extends Fallable

@export var amount: int = 1

# player receives a shield that protects from damage
func on_player_entered(player: Player) -> void:
	player.activate_shield()
	print("shield collected")
