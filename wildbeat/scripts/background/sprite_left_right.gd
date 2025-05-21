extends Sprite2D


func _ready() -> void:
	# moves the sprite from left to right in a loop
	var tween: Tween = create_tween().set_loops()
	tween.tween_property(self, "global_position", Vector2(-100.0, 0.0), 1.0).as_relative()
	tween.tween_property(self, "global_position", Vector2(100.0, 0.0), 1.0).as_relative()
