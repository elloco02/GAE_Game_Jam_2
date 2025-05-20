extends AudioButton

@onready var pause_menu: PauseMenu = $"../../.."


func button_pressed() -> void:
	pause_menu.hide_pause_menu()
