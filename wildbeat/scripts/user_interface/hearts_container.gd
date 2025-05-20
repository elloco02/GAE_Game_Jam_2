extends HBoxContainer

@onready var HeartGui = preload("res://scenes/user_interface/heart_gui.tscn")

@export var player: Player

func _ready() -> void:
	if not player:
		assert(false, "HeartsContainer is missing Player.")

	set_max_hearts(player.health.max_health)
	# Player is created before, so we have to manually set the health once
	update_hearts(player.health.current_health)
	player.health.health_changed.connect(update_hearts)


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
