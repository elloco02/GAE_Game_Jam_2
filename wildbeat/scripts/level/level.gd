extends Node2D

@onready var board : TileMapLayer = $Board
@onready var player: Node2D = $Player
@onready var pause_menu = preload("res://scenes/menu/pause_menu.tscn").instantiate()

const TOTAL_TILES := 31
const BORDER_TILES := 2
const PLAYABLE_TILES := TOTAL_TILES - BORDER_TILES  # 30
const COLUMNS := 5
const TILES_PER_COLUMN := PLAYABLE_TILES / COLUMNS  # 6
const TILE_SIZE := 16  # in Pixeln
	
func _ready():
	get_node("/root/GameManager").add_child(pause_menu)
	#val bla = get_tree().path
	#bla.add_child()
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
