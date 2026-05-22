extends Node2D

@onready var grid = $GridContainer
@onready var hp_label = $CanvasLayer/HpLabel
@onready var gold_label = $CanvasLayer/GoldLabel
@onready var restart_button = $CanvasLayer/RestartButton

var cell_scene = preload("res://scenes/Cell.tscn")

var cells = []

var player_position = 4

var player_hp = 10
var player_gold = 0

func _on_restart_pressed():

	get_tree().reload_current_scene()

func game_over():

	print("GAME OVER")

	restart_button.visible = true

func update_ui():

	hp_label.text = "HP: " + str(player_hp)

	gold_label.text = "Gold: " + str(player_gold)

func _ready():

	randomize()

	create_grid()

	update_player_cell()

	update_ui()
	
	restart_button.pressed.connect(_on_restart_pressed)

func create_grid():

	for i in range(9):

		var cell = cell_scene.instantiate()

		var random_type = get_random_cell_type()

		grid.add_child(cell)

		cell.set_data(
			random_type,
			randi_range(1, 5)
		)

		cell.pressed.connect(_on_cell_pressed.bind(i))

		cells.append(cell)


func get_random_cell_type():

	var random_value = randi() % 3

	match random_value:

		0:
			return Cell.CellType.ENEMY

		1:
			return Cell.CellType.HEAL

		2:
			return Cell.CellType.GOLD

	return Cell.CellType.EMPTY


func update_player_cell():

	cells[player_position].set_data(
		Cell.CellType.PLAYER,
		0
	)


func _on_cell_pressed(index):

	if not is_adjacent(index):
		return

	var target_cell = cells[index]

	match target_cell.type:

		Cell.CellType.ENEMY:
			player_hp -= target_cell.value

		Cell.CellType.HEAL:
			player_hp += target_cell.value

		Cell.CellType.GOLD:
			player_gold += target_cell.value


	cells[player_position].set_data(
		get_random_cell_type(),
		randi_range(1, 5)
	)

	player_position = index

	update_player_cell()

	print("HP: ", player_hp)
	print("Gold: ", player_gold)
	
	update_ui()
	
	if player_hp <= 0:
		game_over()


func is_adjacent(index):

	var row = player_position / 3
	var col = player_position % 3

	var target_row = index / 3
	var target_col = index % 3

	var row_difference = abs(row - target_row)
	var col_difference = abs(col - target_col)

	return row_difference + col_difference == 1
