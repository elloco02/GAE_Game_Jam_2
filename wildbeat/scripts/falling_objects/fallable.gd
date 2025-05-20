class_name Fallable

extends Area2D

@export var fall_speed: float = 100.0
@export var fall_step: float = 1.0
@export var spawn_weight: float = 1.0

func _ready():
	self.body_entered.connect(handle_body_entered)


func _physics_process(delta: float) -> void:
	fall_down(delta)


func handle_body_entered(body: Node) -> void:
	if body is Player:
		on_player_entered(body)
	elif body is Fallable:
		on_fallable_entered(body)
	remove_fallable()


# Should be implemented by the inheriting classes
func on_player_entered(_player: Player) -> void:
	pass


# Should be implemented by the inheriting classes
func on_fallable_entered(_fallable: Fallable) -> void:
	pass


func fall_down(time: float) -> void:
	self.position.y = self.position.y + fall_speed * time * fall_step


# Not doing queue_free() immediately to allow for the animation to play
func remove_fallable() -> void:
	var childs = get_children()
	for child in childs:
		if child is CollisionShape2D or child is ColorRect:
			child.queue_free()
	fall_speed = 0
	get_tree().create_timer(5).timeout.connect(_free)


func _free() -> void:
	queue_free()
