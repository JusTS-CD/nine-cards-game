extends Button

enum CellType {
	EMPTY,
	PLAYER,
	ENEMY,
	HEAL,
	GOLD
}

var type = CellType.EMPTY
var value = 0


func set_data(new_type, new_value):

	type = new_type
	value = new_value

	update_visual()


func update_visual():

	match type:

		CellType.EMPTY:
			text = ""

		CellType.PLAYER:
			text = "🙂"

		CellType.ENEMY:
			text = "👾 " + str(value)

		CellType.HEAL:
			text = "❤️ " + str(value)

		CellType.GOLD:
			text = "💰 " + str(value)
