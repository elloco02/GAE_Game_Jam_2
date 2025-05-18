extends Node2D

@onready var board : TileMapLayer = $Board
@onready var player: Node2D = $Player
@onready var pause_menu = preload("res://scenes/menu/pause_menu.tscn").instantiate()
@onready var heartsContainer: HBoxContainer = $UserInterface/HeartsContainer

const TOTAL_TILES : float = 31
const BORDER_TILES : float = 2
const PLAYABLE_TILES : float = TOTAL_TILES - BORDER_TILES  # 29
const COLUMNS : float = 5
const TILES_PER_COLUMN : float = 6
const TILE_SIZE : float = 16  # in Pixeln
	
func _ready():
	AudioManager.create_2d_audio_at_location(global_position, SoundEffectSettings.SOUND_EFFECT_TYPE.BACKGROUND_MUSIC)
	get_node("/root/GameManager").add_child(pause_menu)
	var screen_size = get_viewport().get_visible_rect().size
	var board_pixel_width = TOTAL_TILES * TILE_SIZE

	# Board (TileMapLayer) horizontal zentrieren
	board.position.x = (screen_size.x - board_pixel_width) / 2
	board.position.y = screen_size.y / 6

	# Grid-Dimensionen analysieren
	var grid_rect = board.get_used_rect()
	var border_y = grid_rect.position.y + grid_rect.size.y - 1  # letzte Zeile
	var player_y = border_y - 3  # eine Zeile über der Border

	# Mittlere Spalte berechnen
	var middle_column = COLUMNS / 2
	var tile_index_in_column = BORDER_TILES / 2 + middle_column * TILES_PER_COLUMN + TILES_PER_COLUMN / 2
	var player_x = int(tile_index_in_column)

	# TileMapLayer-Koordinaten → Welt-Position
	var player_tile_pos = Vector2i(player_x, player_y)
	var player_pixel_pos = board.map_to_local(player_tile_pos) + board.position

	# Spieler global setzen
	player.global_position = player_pixel_pos
	
	# User Interface
	heartsContainer.set_max_hearts(player.max_health)
	heartsContainer.update_hearts(player.current_health)
	player.health_changed.connect(heartsContainer.update_hearts)
	
	# Create spawner
	create_spawners()

func create_spawners():
	for i in range(COLUMNS):
		var spawnerName = "Spawner" + str(i+1)
		var spawner = get_node(spawnerName)
		move_spawner_to_column(spawner, i)
		
func move_spawner_to_column(spawner: Spawner, column_index: int):
	var grid_rect = board.get_used_rect()
	var start_x = BORDER_TILES / 2
	var tile_x = start_x + column_index * TILES_PER_COLUMN + (TILES_PER_COLUMN - 1) / 2.0

	var tile_pos = Vector2(int(tile_x), grid_rect.position.y)
	var pixel_pos = board.map_to_local(tile_pos) + board.position	
	spawner.position = pixel_pos
