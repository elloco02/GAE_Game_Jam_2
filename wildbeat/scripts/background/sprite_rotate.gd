extends Sprite2D


func _ready() -> void:
	# rotates the sprite by 360 degrees in a loop
	var tween: Tween = create_tween().set_loops()
	tween.tween_property(self, "rotation", deg_to_rad(360), 2.0).from_current()
