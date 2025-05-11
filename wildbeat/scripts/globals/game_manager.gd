extends Node

var time_alive := 0.0
var is_alive := true

func _process(delta):
	if is_alive:
		time_alive += delta

func display_time():
	is_alive = false
	var root = get_tree().get_current_scene()
	print("root:" + str(root))
	var label = get_tree().current_scene.get_node("Label")
	if label:
		label.text = "Du hast " + str("%0.2f" % time_alive)  + " Sekunden überlebt"
	print("time alive:" + str(time_alive))

	
