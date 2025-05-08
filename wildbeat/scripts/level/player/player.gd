extends Node2D

@onready var board : TileMapLayer = get_parent().get_node("Board")

@export var max_health := 3
var current_healh := 0

const COLUMNS := 5
const TILES_PER_COLUMN : int = 6
const BORDER_TILES : int = 2

var current_column : int = 2

func _ready():
	move_to_column(current_column)
	current_healh = max_health

func _process(delta):
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

	var tile_pos = Vector2(tile_x, target_tile_y)
	var pixel_pos = board.map_to_local(tile_pos) + board.position

	global_position = pixel_pos

func player_dies():
	print("player died.")
	SceneManager.change_scene_to("res://scenes/menu/main_menu.tscn")

func take_damage(damage : int = 1):
	print("taking damage: " + str(damage))
	current_healh -= damage
	if current_healh <= 0:
		player_dies()
	
