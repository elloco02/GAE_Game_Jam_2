extends Sprite2D


func _ready() -> void:
	# scales the sprite up and down by 50% in a loop
	var tween: Tween = create_tween().set_loops()
	tween.tween_property(self, "scale", Vector2(0.5, 0.5), 1.5)
	tween.tween_property(self, "scale", Vector2(1.5, 1.5), 1.5)
