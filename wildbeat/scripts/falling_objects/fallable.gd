class_name Fallable

extends Area2D

@export var fall_speed: float = 100.0
@export var fall_step: float = 1
@export var width: float = 48.0
@export var height: float = 48.0
@export var spawn_weight: float = 1.0

@onready var fallable_collision: CollisionShape2D = $FallableCollision

var color_rect: ColorRect = null

func _ready():
	if self.get_children().get(0) is ColorRect:
		color_rect = self.get_children().get(0)
	else:
		push_error("ColorRect not set. Please set the ColorRect node in the inspector.")
		return
	fallable_collision.shape.get_rect().size = Vector2(width, height)
	var shape = fallable_collision.shape
	var pos = fallable_collision.position
	color_rect.shape = shape
	color_rect.position = pos
	self.body_entered.connect(handle_body_entered)


func _physics_process(delta: float) -> void:
	fall_down(delta)


func handle_body_entered(body: Node) -> void:
	if body is Player:
		on_player_entered(body)
	elif body is Fallable:
		on_fallable_entered(body)


# Should be implemented by the inheriting classes
func on_player_entered(_player: Player) -> void:
	queue_free() # Default behavior is to remove the object


func on_fallable_entered(_fallable: Fallable) -> void:
	queue_free() # Default behavior is to remove the object


func fall_down(time: float) -> void:
	self.position.y = self.position.y + fall_speed * time * fall_step
