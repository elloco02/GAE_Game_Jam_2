class_name FallableDamage

extends Fallable

@export var damage: int = 1

func on_player_entered(player: Player) -> void:
	if !player.shielded:
		$UniversalCollectParticles.emitting = true
	player.take_damage(damage)
	print("dealing ", damage, " damage to player")
