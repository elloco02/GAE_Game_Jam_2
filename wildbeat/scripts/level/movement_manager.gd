class_name MovementManager

extends Node2D

@export var board: TileMapLayer
@export var columns: int = 5
@export var border_tiles_x: int = 2
@export var border_tiles_y: int = 2
@export var player_offset_y: int = 3

var tile_size: Vector2i # in pixels
var board_rect: Rect2i # in tiles
var tiles_per_column_x: float

func _ready() -> void:
	if not board:
		assert(false, "MovementManager is missing a board.")
	tile_size = board.tile_set.tile_size
	board_rect = board.get_used_rect()
	# dont remove border_tiles_x / 2.0, for some reason it is needed for proper positioning
	tiles_per_column_x = (board_rect.size.x - border_tiles_x / 2.0) / float(columns)


# Returns the global position of the tile in the grid or (-1, -1) if the column is out of bounds.
func get_column_position(column: int, top: bool = false) -> Vector2:
	if column < 0:
		return Vector2(-1, -1)
	elif column > columns - 1:
		return Vector2(-1, -1)

	var y = get_y_coordinate(top)
	var x = get_x_coordinate(column)

	var new_position = board.map_to_local(Vector2(x, y)) + board.position

	return new_position


func get_y_coordinate(top: bool) -> int:
	if top:
		return board_rect.position.y

	var y_correction = player_offset_y + border_tiles_y / 2.0
	return board_rect.position.y + board_rect.size.y - y_correction


func get_x_coordinate(column: int) -> int:
	var start_x = border_tiles_x / 2.0
	var position_x = start_x + column * tiles_per_column_x + (tiles_per_column_x - 1) / 2.0

	return int(position_x)
