class_name FallableShield

extends Fallable

# Player receives a shield
func on_player_entered(player: Player) -> void:
	print("shield collected")
	if player.shield:
		player.shield.activate()
