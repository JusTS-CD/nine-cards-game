extends Button
class_name Cell

enum CellType {
	EMPTY,
	PLAYER,
	ENEMY,
	HEAL,
	GOLD
}

var type = CellType.EMPTY
var value = 0

@onready var card_texture = $TextureRect
@onready var label = $Label

var player_texture = preload("res://assets/cards/player.jpg")
var enemy_textures = [
	preload("res://assets/cards/enemy.jpg"),
	preload("res://assets/cards/enemy2.jpg")
]
var heal_textures = [
	preload("res://assets/cards/heal.jpg"),
	preload("res://assets/cards/heal2.jpg"),
]
var gold_texture = preload("res://assets/cards/gold.jpg")

func set_data(new_type, new_value):

	type = new_type
	value = new_value

	update_visual()


func update_visual():

	match type:

		CellType.EMPTY:
			card_texture.texture = null
			label.text = ""

		CellType.PLAYER:
			card_texture.texture = player_texture
			label.text = ""

		CellType.ENEMY:
			card_texture.texture = enemy_textures.pick_random()
			label.text = str(value)

		CellType.HEAL:
			card_texture.texture = heal_textures.pick_random()
			label.text = str(value)

		CellType.GOLD:
			card_texture.texture = gold_texture
			label.text = str(value)
