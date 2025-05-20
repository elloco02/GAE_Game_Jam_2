class_name Spawner

extends Marker2D

@onready var spawn_timer: Timer = Timer.new()

# Dictionary of type {"scene": PackedScene, "weight": float, "name": String}
var fallables: Array[Dictionary] = []
var slowed: bool = false # make sure newly spawned fallables are also slowed
var total_weight: float = 0

func _ready() -> void:
	init_fallables()

	if fallables.size() == 0:
		push_error("No fallables found in the scene.")
		return
	else:
		print("Spawnables initialized: ", fallables.size())

	init_timer()


func init_fallables() -> void:
	for child in get_children():
		if child is Fallable:
			var packed = PackedScene.new()
			packed.pack(child)
			fallables.append({
				"scene": packed,
				"weight": child.spawn_weight,
				"name": child.name
			})
			print("Added spawnable: ", child.name, " with weight: ", child.spawn_weight)
			total_weight += child.spawn_weight
			child.queue_free()


func init_timer() -> void:
	spawn_timer.one_shot = true # Timer must expire before it can be restarted
	spawn_timer.timeout.connect(handle_timer_timeout)
	add_child(spawn_timer)
	start_timer()


func start_timer() -> void:
	var wait_time = randf_range(2.0, 5.0)
	spawn_timer.start(wait_time)


func handle_timer_timeout() -> void:
	spawn()
	start_timer()


func spawn() -> void:
	if fallables.size() == 0:
		push_error("No fallables available to spawn.")
		return

	var random_index = get_random_index()
	if random_index == -1:
		push_error("Failed to get a random index.")
		return

	var fallable = fallables[random_index]
	var instance: Fallable = fallable["scene"].instantiate()
	add_child(instance)
	# FIXME:
	if self.slowed:
		instance.fall_step = 0.5
	print("Spawned: ", fallable["name"])


# Basic weighted random number generator
func get_random_index() -> int:
	var random_value = randf() * total_weight
	var cumulative_weight = 0.0

	for i in range(fallables.size()):
		cumulative_weight += fallables[i]["weight"]
		if random_value <= cumulative_weight:
			return i

	return -1 # Should never reach here if weights are set correctly
