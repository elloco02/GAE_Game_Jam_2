extends Area2D

func _ready():
	self.area_entered.connect(handle_body_entered)


func handle_body_entered(body: Area2D) -> void:
	if body is Fallable:
		body.queue_free()
