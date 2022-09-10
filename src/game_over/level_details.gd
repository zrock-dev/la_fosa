extends HBoxContainer

const dataFormat = preload("res://src/game_over/Data.tscn")
const dataNames = [
	"Score:",
	"Extra Points:",
	"Enemies level:",
]

var data = []

func _ready():
	init_data()


func init_data():
	for title in dataNames :
		var aux_data = dataFormat.instance()
		aux_data.set_details(title, "9")
		data.append(aux_data)
		add_child(aux_data)
