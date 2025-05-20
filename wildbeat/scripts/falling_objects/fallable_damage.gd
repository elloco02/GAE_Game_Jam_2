class_name FallableDamage

extends Fallable

@export var damage: int = 1

# Player receives damage
func on_player_entered(player: Player) -> void:
	player.take_damage(damage)
	print("dealing ", damage, " damage to player")


func play_particles(player: Player) -> void:
	if collect_particles and player.shield and not player.shield.is_active:
		collect_particles.emitting = true
