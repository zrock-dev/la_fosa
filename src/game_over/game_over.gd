extends CanvasLayer

var before_scene

onready var image = $MarginContainer/Panel/Container/Body/Image
onready var news_name = get_node("MarginContainer/Panel/Container/Header/NewsName")
onready var article = get_node("MarginContainer/Panel/Container/Body/Article")
onready var data_points = get_node("MarginContainer/Panel/Container/Foot/Points")

func _ready():
	pass 

func set_image(path):
	image.texture.take_over_path(path)

func set_before_scene(path):
	before_scene = path

func _on_Try_Again_button_down():
	get_tree().change_scene(before_scene)

func _on_Credits_button_down():
	pass # Replace with function body.

func _on_Quit_button_down():
	get_tree().change_scene("res://src/game/main_menu.tscn")
