extends Area2D

const FALL_SPEED := 100.0 # Pixel pro Sekunde

func _physics_process(delta: float) -> void:
	self.position.y = self.position.y + FALL_SPEED * delta
