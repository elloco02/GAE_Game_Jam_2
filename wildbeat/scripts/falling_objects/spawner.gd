class_name Spawner

extends Node2D

var spawnables: Array[PackedScene] = []
var total_weight: float = 0

func _ready() -> void:
    # Initialize the spawnables array with all Fallable childs
    for child in get_children():
        if child is Fallable:
            var packed = PackedScene.new()
            packed.pack(child)
            spawnables.append(packed)
            print("Added spawnable: ", child.name)
            total_weight += child.spawn_weight
            child.queue_free()
    if spawnables.size() == 0:
        push_error("No spawnables found in the scene.")
    else:
        print("Spawnables initialized: ", spawnables.size())


func spawn() -> void:
    if spawnables.size() == 0:
        push_error("No spawnables available to spawn.")
        return

    var random_index = get_random_index()
    var packed_scene = spawnables[random_index]
    var instance: Fallable = packed_scene.instantiate()
    add_child(instance)
    instance.global_position = global_position # Set the position of the spawned object to the spawner's position
    print("Spawned: ", instance.name)


func get_random_index() -> int:
    var random_value = randf() * total_weight
    var cumulative_weight = 0.0

    for i in range(spawnables.size()):
        cumulative_weight += spawnables[i].spawn_weight
        if random_value <= cumulative_weight:
            return i

    return -1 # Should never reach here if weights are set correctly