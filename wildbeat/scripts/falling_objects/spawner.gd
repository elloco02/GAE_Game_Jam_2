class_name Spawner

extends Marker2D

@export var minimum_spawn_delay: float = 1.0
@export var maximum_spawn_delay: float = 10.0
@export var adjust_increase: Array[Fallable.Types] = [Fallable.Types.DAMAGE]
@export var adjust_decrease: Array[Fallable.Types] = [
	Fallable.Types.SHIELD,
	Fallable.Types.HEAL,
	Fallable.Types.SLOW_MOTION
]
@export var min_weight: float = 1.0
@export var max_weight: float = 100.0
@export var adjust_by: float = 0.1

@onready var spawn_timer: Timer = Timer.new()

# Dictionary of type {"scene": PackedScene, "weight": float, "name": String, "type": Fallables}
var fallables: Array[Dictionary] = []
var slowed: bool = false # make sure newly spawned fallables are also slowed

func _ready() -> void:
	init_fallables()

	if fallables.size() == 0:
		push_error("No fallables found in the scene.")
		return
	else:
		print("Spawnables initialized: ", fallables.size())

	init_timer()

	ScoreManager.on_score_change.connect(handle_score_change)


# adjust the Fallable weights and maximum_spawn_delay for each coin collected:
# decrease the maximum_spawn_delay by 0.5 seconds
# decrease the weight for FallableHeal, FallableShield and FallableSlowMotion by 0.1
# increase the weight for FallableDamage by 0.1
func handle_score_change(new_score: int) -> void:
	maximum_spawn_delay = max(maximum_spawn_delay - (new_score / 200.0), 2.0)
	print("maximum_spawn_delay: ", maximum_spawn_delay)
	# adjust weights of fallables
	for fallable in fallables:
		var type = fallable["type"]
		if type in adjust_increase:
			fallable["weight"] += adjust_by
			print("damaged fallabe spawn weight:", fallable["weight"])
		elif type in adjust_decrease:
			fallable["weight"] -= adjust_by

		fallable["weight"] = clamp(fallable["weight"], min_weight, max_weight)


func init_fallables() -> void:
	for child in get_children():
		if child is Fallable:
			var packed = PackedScene.new()
			packed.pack(child)
			fallables.append({
				"scene": packed,
				"weight": child.spawn_weight,
				"name": child.name,
				"type": child.fallable_type
			})
			print("Added spawnable: ", child.name, " with weight: ", child.spawn_weight)
			child.queue_free()


func init_timer() -> void:
	spawn_timer.one_shot = true # Timer must expire before it can be restarted
	spawn_timer.timeout.connect(handle_timer_timeout)
	add_child(spawn_timer)
	start_timer()


func start_timer() -> void:
	var wait_time = randf_range(minimum_spawn_delay, maximum_spawn_delay)
	spawn_timer.start(wait_time)


func handle_timer_timeout() -> void:
	spawn()
	start_timer()


func spawn() -> void:
	AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.SPAWB_ITEM)
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
	var total_weight = 0.0
	for fallable in fallables:
		total_weight += fallable["weight"]
	var random_value = randf() * total_weight
	var cumulative_weight = 0.0

	for i in range(fallables.size()):
		cumulative_weight += fallables[i]["weight"]
		if random_value <= cumulative_weight:
			return i

	return -1 # Should never reach here if weights are set correctly
