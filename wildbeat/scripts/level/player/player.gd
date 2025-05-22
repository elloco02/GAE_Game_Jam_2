class_name Player
extends Node2D

@export var movement_manager: MovementManager

@onready var animation_handler: AnimatedSprite2D = $AnimationPlayer

var current_column: int = 2

var shield: Shield = null
var health: Health = null
var is_dead: bool = false

func _ready():
	if not init_composition_components():
		assert(false, "Player is missing vital components.")
	if not movement_manager:
		assert(false, "Player is missing movement manager.")
	health.died.connect(player_dies)
	animation_handler.play_idle()

func init_composition_components() -> bool:
	for child in get_children():
		if child is Health and health == null:
			health = child
		if child is Shield and shield == null:
			shield = child
	return health != null

func _process(_delta):
	if is_dead:
		return

	if Input.is_action_just_pressed("move_left"):
		animation_handler.play_dash_left()
		adjust_player(-1)
	elif Input.is_action_just_pressed("move_right"):
		animation_handler.play_dash_right()
		adjust_player(1)

func adjust_player(adjustment: int) -> void:
	var new_position = movement_manager.get_column_position(current_column + adjustment)
	if new_position == Vector2(-1, -1):
		return
	current_column += adjustment
	self.global_position = new_position
	AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.PLAYER_MOVE)

func move_player_to(column: int) -> void:
	var new_position = movement_manager.get_column_position(column)
	if new_position == Vector2(-1, -1):
		assert(false, "Player is out of bounds.")
		return
	self.global_position = new_position

func player_dies():
	is_dead = true
	animation_handler.play_dies()
	GameManager.end_game()
