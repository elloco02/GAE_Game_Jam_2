extends HBoxContainer

@onready var HeartGui = preload("res://scenes/user_interface/heart_gui.tscn")

func set_max_hearts(max_hearts: int) -> void:
	for i in range(max_hearts):
		var heart = HeartGui.instantiate()
		add_child(heart)

func update_hearts(current_health: int) -> void:
	var hearts = get_children()
	
	for i in range(current_health):
		hearts[i].update(true)
	
	for i in range(current_health, hearts.size()):
		hearts[i].update(false)
