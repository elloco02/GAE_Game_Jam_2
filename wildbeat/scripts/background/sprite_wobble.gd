extends Sprite2D


func _ready() -> void:
	# makes the sprite wobble by scaling it up and down by 50% and rotating it
	# left to right by 45 degrees in a loop
	var tween: Tween = create_tween().set_loops().set_parallel(true)
	tween.tween_property(self, "scale", Vector2(1.5, 1.5), 1.0)
	tween.tween_property(self, "rotation", deg_to_rad(45), 1.0)
	tween.chain().tween_property(self, "scale", Vector2(1.0, 1.0), 1.0)
	tween.tween_property(self, "rotation", deg_to_rad(-45), 1.0)
	
