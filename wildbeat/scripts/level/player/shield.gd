class_name Shield

extends Node2D

@export var shield_particle: ShieldParticle

var is_active: bool:
	set(value):
		is_active = value
		if shield_particle:
			shield_particle.emitting = value


func deactivate() -> void:
	is_active = false


func activate() -> void:
	is_active = true
