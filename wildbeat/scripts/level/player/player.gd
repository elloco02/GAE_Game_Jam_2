class_name Player
extends Node2D

@onready var board: TileMapLayer = get_parent().get_node("Board")

@export var max_health := 3
var current_health := 0
var shielded: bool:
	set(val):
		shielded = val
		$ShieldParticle.emitting = val

const COLUMNS: float = 5
const TILES_PER_COLUMN: float = 6
const BORDER_TILES: float = 2

var current_column: int = 2

signal health_changed

func _ready():
	current_health = max_health

func _process(_delta):
	if Input.is_action_just_pressed("move_left") and current_column > 0:
		current_column -= 1
		move_to_column(current_column)
	elif Input.is_action_just_pressed("move_right") and current_column < COLUMNS - 1:
		current_column += 1
		move_to_column(current_column)

func move_to_column(column_index: int):
	var grid_rect = board.get_used_rect()
	var border_y = grid_rect.position.y + grid_rect.size.y - 1
	var target_tile_y = border_y - 3

	var start_x = BORDER_TILES / 2 
	var tile_x = start_x + column_index * TILES_PER_COLUMN + (TILES_PER_COLUMN - 1) / 2.0

	var tile_pos = Vector2(int(tile_x), target_tile_y)
	var pixel_pos = board.map_to_local(tile_pos) + board.position

	global_position = pixel_pos
	AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.PLAYER_MOVE)

func player_dies():
	AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.PLAYER_DIES)
	print("player died.")
	await SceneManager.change_scene_to("res://scenes/menu/player_death.tscn")
	GameManager.display_time()


func take_damage(damage: int = 1):
	# deactivate shield if activated
	if self.shielded:
		print("shield took ", damage, " damage")
		print("shield deactivated")
		self.shielded = false
	# take damage if no shield activated
	else:
		print("taking damage: " + str(damage))
		AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.PLAYER_DAMAGE)
		current_health -= damage
		health_changed.emit(current_health)
		if current_health <= 0:
			player_dies()

# heal player by amount of not already at max health
func heal(amount: int):
	if self.current_health < self.max_health:
		print("healing: ", str(amount))
		self.current_health = min(self.current_health + amount, self.max_health)
		$HealCollectParticle.emitting = true
		health_changed.emit(self.current_health)
	else:
		print("already full health")

# activate a shield that lasts for one damage hit
func activate_shield():
	self.shielded = true
