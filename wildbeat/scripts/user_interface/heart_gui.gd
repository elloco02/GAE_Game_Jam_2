extends Panel

@onready var filled_rect: ColorRect = $Filled
@onready var empty_rect: ColorRect = $Empty 

func update(filled: bool) -> void:
	if filled:
		filled_rect.visible = true
		empty_rect.visible = false
	else:
		filled_rect.visible = false
		empty_rect.visible = true
