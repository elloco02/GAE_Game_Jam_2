extends Sprite2D


func _ready() -> void:
	# moves the sprite from right to left while spinning it by 180 degrees with the direction
	# in a loop
	var tween: Tween = create_tween().set_loops().set_parallel(true)
	tween.tween_property(self, "global_position", Vector2(75.0, 0.0), 2.0).as_relative()
	tween.tween_property(self, "rotation", deg_to_rad(180), 2.0).from(deg_to_rad(-180))
	tween.chain().tween_property(self, "global_position", Vector2(-75.0, 0.0), 2.0).as_relative()
	tween.tween_property(self, "rotation", deg_to_rad(-180), 2.0).from(deg_to_rad(180))
