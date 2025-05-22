extends Sprite2D


func _ready() -> void:
	# moves the sprite up and down in a loop
	var tween: Tween = create_tween().set_loops()
	tween.tween_property(self, "global_position", Vector2(0.0, -100.0), 4.75).as_relative()
	tween.tween_property(self, "global_position", Vector2(0.0, 100.0), 4.75).as_relative()
