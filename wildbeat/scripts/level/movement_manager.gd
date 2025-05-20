class_name MovementManager

extends Node2D

@onready var board: TileMapLayer = get_parent().get_node("Board")

const COLUMNS: float = 5
const TILES_PER_COLUMN: float = 6
const BORDER_TILES: float = 2

# Returns the new column position
func move_to_column(_column: int, _top: bool = false) -> int:
	return false


var current_column: int = 2

func move_to_columnasdf(column_index: int):
	var grid_rect = board.get_used_rect()
	var border_y = grid_rect.position.y + grid_rect.size.y - 1
	var target_tile_y = border_y - 3

	var start_x = BORDER_TILES / 2
	var tile_x = start_x + column_index * TILES_PER_COLUMN + (TILES_PER_COLUMN - 1) / 2.0

	var tile_pos = Vector2(int(tile_x), target_tile_y)
	var pixel_pos = board.map_to_local(tile_pos) + board.position

	global_position = pixel_pos
