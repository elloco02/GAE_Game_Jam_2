class_name Fallable

extends Area2D

@export var fall_speed: float = 100.0
@export var fall_step: float = 1

func _ready():
	self.body_entered.connect(handle_body_entered)


func _physics_process(delta: float) -> void:
	fall_down(delta)


func handle_body_entered(body: Node) -> void:
	if body is Player:
		on_player_entered(body)
	elif body is Fallable:
		on_fallable_entered(body)


func on_player_entered(_player: Player) -> void:
	# Should be implemented by the inheriting classes
	pass


func on_fallable_entered(_fallable: Fallable) -> void:
	# TODO: for now, we just remove the object
	queue_free()


func fall_down(time: float) -> void:
	self.position.y = self.position.y + fall_speed * time * fall_step