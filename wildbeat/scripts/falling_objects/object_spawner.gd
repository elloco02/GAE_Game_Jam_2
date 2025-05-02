extends Node2D

@export var object_scene: PackedScene = preload("res://scenes/falling_objects/falling_object.tscn")
@export var spawn_position: Vector2 = Vector2(0, 0)

@onready var spawn_timer := Timer.new()

func _ready():
	spawn_timer.one_shot = true # Timer muss ablaufen bevor er neu starten kann
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	add_child(spawn_timer)
	_start_random_spawn()

# Setze Timer auf einen zufälligen Spawnintervall zwischen 2 und 5 Sekunden
func _start_random_spawn():
	var wait_time = randf_range(2.0, 5.0)
	spawn_timer.start(wait_time)

# Spawne neues Objekt wenn Timer abgelaufen ist und starte Timer neu
func _on_spawn_timer_timeout():
	spawn_object()
	_start_random_spawn()

# Spawn neues Objekt an der Position des Spawners, wenn Timer abgelaufen ist
func spawn_object():
	var spawned_object = object_scene.instantiate()
	spawned_object.global_position = spawn_position
	add_child(spawned_object)
