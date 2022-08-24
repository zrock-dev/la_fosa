extends Control

onready var label := $HBoxContainer/Label
onready var texture := $HBoxContainer/TextureRect
onready var label_color = $HBoxContainer/Label.get_stylebox("normal", "")

var info_image = preload("res://assets/in-game-alerts/info.png")
var warning_image = preload("res://assets/in-game-alerts/warning.png")
var danger_image = preload("res://assets/in-game-alerts/danger.png")

var warning_color = Color.yellow
var danger_color = Color.red
var info_color = Color.blue

enum MessageType {Info, Warning, Danger}

func _Message(var message, var type):
	label.text = message
	
	if type == MessageType.Warning:
		texture.set_texture(warning_image)
		label_color.border_color = warning_color
		
	elif type == MessageType.Danger:
		texture.set_texture(danger_image)
		label_color.border_color = danger_color
		
	elif type == MessageType.Info:
		texture.set_texture(info_image)
		label_color.border_color = info_color
		
	label_color.bg_color = label_color.border_color
