extends Sprite2D


func _ready() -> void:
	var tween: Tween = create_tween().set_loops().set_parallel(true)
	tween.tween_property(self, "global_position", Vector2(0.0, 75.0), 2.0).as_relative()
	tween.tween_property(self, "rotation", deg_to_rad(360), 2.0).from_current()
	tween.chain().tween_property(self, "global_position", Vector2(0.0, -75.0), 2.0).as_relative()
