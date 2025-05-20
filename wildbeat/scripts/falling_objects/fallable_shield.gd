class_name FallableShield

extends Fallable

# player receives a shield that protects from damage
func on_player_entered(player: Player) -> void:
	player.activate_shield()
	print("shield collected")
