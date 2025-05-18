extends Control

func _ready():
	visible = false
	get_node("MarginContainer/VBoxContainer/Resume").pressed.connect(_on_resume_pressed)
	get_node("MarginContainer/VBoxContainer/Main Menu").pressed.connect(_on_resume_pressed)
	set_process(false)
	set_process_internal(false) 

func _input(event):
	if event.is_action_pressed("pause_game"):
		if get_tree().paused:
			hide_pause_menu()
			print("currently pause resumning game")
		else:
			show_pause_menu()
			print("pausing game")
			
func show_pause_menu():
	get_tree().paused = true
	visible = true

func hide_pause_menu():
	get_tree().paused = false
	visible = false

func _on_resume_pressed():
	AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.UI_BUTTON_PRESSED)
	hide_pause_menu()
	
func _on_main_menu_pressed():
	hide_pause_menu()
	SceneManager.change_scene_to("")
