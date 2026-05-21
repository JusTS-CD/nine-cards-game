extends Node2D

const GRID_SIZE = 3

@onready var grid = $GridContainer

var cell_scene = preload("res://scenes/Cell.tscn")

var cells = []
var player_index = 4


func _ready():
	create_grid()
	update_grid()


func create_grid():
	for i in range(GRID_SIZE * GRID_SIZE):
		var cell = cell_scene.instantiate()

		cell.pressed.connect(func(): on_cell_pressed(i))

		grid.add_child(cell)
		cells.append(cell)


func update_grid():
	for i in range(cells.size()):

		if i == player_index:
			cells[i].set_data(1, 0)
		else:
			cells[i].set_data(0, 0)


func on_cell_pressed(index):

	if is_neighbor(index):
		player_index = index
		update_grid()


func is_neighbor(index):

	var player_x = player_index % GRID_SIZE
	var player_y = player_index / GRID_SIZE

	var target_x = index % GRID_SIZE
	var target_y = index / GRID_SIZE

	var dx = abs(player_x - target_x)
	var dy = abs(player_y - target_y)

	return dx + dy == 1
