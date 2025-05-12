class_name Spawner

extends Marker2D

@onready var spawn_timer: Timer = Timer.new()

# Dictionary of type {"scene": PackedScene, "weight": float}
var fallables: Array[Dictionary] = []
var total_weight: float = 0

func _ready() -> void:
	# Initialize the fallables array with all Fallable childs
	for child in get_children():
		if child is Fallable:
			var packed = PackedScene.new()
			packed.pack(child)
			fallables.append({
				"scene": packed,
				"weight": child.spawn_weight
			})
			print("Added spawnable: ", child.name, " with class ", child.get_class())
			total_weight += child.spawn_weight
			child.queue_free()

	if fallables.size() == 0:
		push_error("No fallables found in the scene.")
	else:
		print("Spawnables initialized: ", fallables.size())

	spawn_timer.one_shot = true # Timer must expire before it can be restarted
	spawn_timer.timeout.connect(_handle_timer_timeout)
	add_child(spawn_timer)
	_start_timer()


func _start_timer() -> void:
	var wait_time = randf_range(2.0, 5.0)
	spawn_timer.start(wait_time)


func _handle_timer_timeout() -> void:
	spawn()
	_start_timer()


func spawn() -> void:
	if fallables.size() == 0:
		push_error("No fallables available to spawn.")
		return

	var random_index = get_random_index()
	if random_index == -1:
		push_error("Failed to get a random index.")
		return

	var packed_scene = fallables[random_index]["scene"]
	var instance: Fallable = packed_scene.instantiate()
	instance.global_position = global_position # Set the position of the spawned object to the spawner's position
	print("Color: ", instance.color)
	add_child(instance)
	print("Spawned: ", instance.name, " with class: ", instance.get_class())


func get_random_index() -> int:
	var random_value = randf() * total_weight
	var cumulative_weight = 0.0

	for i in range(fallables.size()):
		cumulative_weight += fallables[i]["weight"]
		if random_value <= cumulative_weight:
			return i

	return -1 # Should never reach here if weights are set correctly
