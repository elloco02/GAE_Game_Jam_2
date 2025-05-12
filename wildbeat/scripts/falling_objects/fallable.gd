class_name Fallable

extends Area2D

@export var fall_speed: float = 100.0
@export var fall_step: float = 1
@export var width: float = 48.0
@export var height: float = 48.0
@export var spawn_weight: float = 1.0
@export var color: Color = Color(1, 1, 1, 1) # Default color is white

@onready var fallable_collision: CollisionShape2D = $FallableCollision
@onready var color_rect: ColorRect = $FallableColor

func _ready():
	_init_objects()
	self.body_entered.connect(handle_body_entered)


func _init_objects():
	fallable_collision.shape.get_rect().size = Vector2(width, height)
	fallable_collision.position = Vector2(-width / 2, -height / 2)
	var shape = fallable_collision.shape
	var pos = fallable_collision.position
	color_rect.size = shape.get_rect().size
	color_rect.position = pos


func _physics_process(delta: float) -> void:
	fall_down(delta)


func handle_body_entered(body: Node) -> void:
	print("Body entered: ", body.name)
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
