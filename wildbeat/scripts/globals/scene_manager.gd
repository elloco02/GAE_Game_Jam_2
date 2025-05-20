extends Node

var current_scene: Node = null
var fade_layer: CanvasLayer
var transition_time := 0.3

func _ready():
	current_scene = get_tree().current_scene

	fade_layer = CanvasLayer.new()
	fade_layer.layer = -100  
	var color_rect = ColorRect.new()
	color_rect.color = Color.BLACK
	color_rect.size = get_viewport().get_visible_rect().size
	color_rect.name = "Fade"
	fade_layer.add_child(color_rect)
	add_child(fade_layer)
	color_rect.modulate.a = 0
	fade_layer.visible = true

func change_scene_to(scene_path: String) -> void:
	fade_out()
	await get_tree().create_timer(transition_time).timeout

	if current_scene:
		current_scene.queue_free()
		if has_node("/root/GameManager"):
			var gameManager = get_node("/root/GameManager")
			if gameManager.get_child_count() > 0:
				gameManager.get_child(0).queue_free()


	var current_music_type = AudioManager.get_current_music_type()

	if scene_path == "res://scenes/level/game_level.tscn":
		if current_music_type != SoundEffectSettings.SOUND_EFFECT_TYPE.BACKGROUND_MUSIC_IN_GAME:
			AudioManager.stop_music(current_music_type)
			AudioManager.create_2d_audio_at_location(Vector2(0, 0), SoundEffectSettings.SOUND_EFFECT_TYPE.BACKGROUND_MUSIC_IN_GAME)
	else:
		if current_music_type != SoundEffectSettings.SOUND_EFFECT_TYPE.BACKGROUND_MUSIC_IN_MENU:
			AudioManager.stop_music(current_music_type)
			AudioManager.create_2d_audio_at_location(Vector2(0, 0), SoundEffectSettings.SOUND_EFFECT_TYPE.BACKGROUND_MUSIC_IN_MENU)
	
	var new_scene = load(scene_path).instantiate()
	get_tree().get_root().add_child(new_scene)
	get_tree().current_scene = new_scene
	current_scene = new_scene

	fade_in()

func fade_out():
	var fade = fade_layer.get_node("Fade")
	fade.modulate.a = 0
	fade_layer.visible = true
	fade.create_tween().tween_property(fade, "modulate:a", 1.0, transition_time)

func fade_in():
	var fade = fade_layer.get_node("Fade")
	fade.create_tween().tween_property(fade, "modulate:a", 0.0, transition_time)
