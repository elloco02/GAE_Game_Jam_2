class_name Health

extends Node2D

@export var max_health: int = 3
@export var shield: Shield
@export var heal_particle: HealCollectParticle

var current_health: int = 0

func _ready() -> void:
	current_health = max_health


func damage(attack: int = 1) -> void:
	if shield and shield.is_active:
		shield.deactivate()
	else:
		current_health -= attack


func heal(amount: int = 1) -> void:
	if current_health < max_health:
		current_health += amount
		if current_health > max_health:
			current_health = max_health
		if heal_particle:
			heal_particle.emitting = true
