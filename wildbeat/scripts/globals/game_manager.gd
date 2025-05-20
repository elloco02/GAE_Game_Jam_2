extends Node

@onready var player_death_scene: PackedScene = preload("res://scenes/menu/player_death.tscn")

func end_game():
	await SceneManager.change_scene_to(player_death_scene)
