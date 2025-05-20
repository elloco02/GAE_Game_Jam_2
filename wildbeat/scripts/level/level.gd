extends Node2D

@onready var board: TileMapLayer = $Board
@onready var player: Node2D = $Player
@onready var pause_menu = preload("res://scenes/menu/pause_menu.tscn").instantiate()

@export var movement_manager: MovementManager
@export var player_start_column: int = 2

func _ready():
	if not movement_manager:
		assert(false, "Level is missing MovementManager.")

	get_node("/root/GameManager").add_child(pause_menu)
	init_board()

	init_spawners()

	player.move_player_to(player_start_column) # move player to start position

	# User Interface
	#heartsContainer.set_max_hearts(player.max_health)
	#heartsContainer.update_hearts(player.current_health)
	#player.health_changed.connect(heartsContainer.update_hearts)


func init_board() -> void:
	var screen_size = get_viewport().get_visible_rect().size
	# Number of tiles on X * tile size of X
	var board_pixel_width = movement_manager.board_rect.size.x * movement_manager.tile_size.x

	# align board to the center of the screen
	board.position.x = (screen_size.x - board_pixel_width) / 2
	board.position.y = screen_size.y / 6


func init_spawners() -> void:
	var spawners: Array[Spawner] = []
	for child in get_children():
		if child is Spawner:
			spawners.append(child)
			print("found spawner: ", child.name)

	if spawners.size() == 0:
		assert(false, "No spawners found in level.")

	for column in range(movement_manager.columns):
		var spawner: Spawner = spawners[column % (spawners.size())]
		var spawner_position = movement_manager.get_column_position(column, true)
		spawner.position = spawner_position
