extends Area2D

func _ready():
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("FallingObject"):
		area.queue_free()
