extends Area2D

const FALL_SPEED := 100.0 # Pixel pro Sekunde

func _ready():
	self.body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	self.position.y = self.position.y + FALL_SPEED * delta

func _on_body_entered(body):
	if body.is_in_group("player") and self.is_in_group("damaging_objects"):
		print("dealing damage to player!!")
		body.take_damage()
		queue_free()
