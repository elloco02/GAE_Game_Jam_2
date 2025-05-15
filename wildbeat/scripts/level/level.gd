extends Node2D

@onready var board : TileMapLayer = $Board
@onready var player: Node2D = $Player
@onready var pause_menu = preload("res://scenes/menu/pause_menu.tscn").instantiate()
@onready var heartsContainer: HBoxContainer = $UserInterface/HeartsContainer

const TOTAL_TILES : float = 31
const BORDER_TILES : float = 2
const PLAYABLE_TILES : float = TOTAL_TILES - BORDER_TILES  # 30
const COLUMNS : float = 5
const TILES_PER_COLUMN : float = PLAYABLE_TILES / COLUMNS  # 6
const TILE_SIZE : float = 16  # in Pixeln
	
func _ready():
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
