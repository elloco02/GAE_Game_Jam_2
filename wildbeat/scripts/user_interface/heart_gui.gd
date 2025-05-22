extends Panel

@onready var filled_image: Sprite2D = $Filled
@onready var empty: Sprite2D = $Empty

func update(filled: bool) -> void:
	if filled:
		filled_image.visible = true
		empty.visible = false
	else:
		filled_image.visible = false
		empty.visible = true
