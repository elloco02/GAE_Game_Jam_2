class_name PauseMenu

extends Control

func _ready():
	visible = false
	set_process(false)
	set_process_internal(false)
	# Set the pause screen to the very front
	z_index = 100


func _input(event):
	if event.is_action_pressed("pause_game"):
		if get_tree().paused:
			hide_pause_menu()
			print("currently pause resuming game")
		else:
			show_pause_menu()
			print("pausing game")


func show_pause_menu():
	get_tree().paused = true
	visible = true


func hide_pause_menu():
	get_tree().paused = false
	visible = false
