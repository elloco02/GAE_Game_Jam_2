extends Sprite2D


func _ready() -> void:
	# scales the sprite up and down by 50% in a loop
	var tween: Tween = create_tween().set_loops()
	tween.tween_property(self, "scale", Vector2(3.5, 3.5), 4.5)
	tween.tween_property(self, "scale", Vector2(4.5, 4.5), 4.5)
