extends Control

var text
var color
onready var label := $HBoxContainer/Label
onready var texture := $HBoxContainer/TextureRect

enum MessageType {Info, Warning, Danger}

func _Message(var message, var type):
	label.text = message
	
	if type is MessageType.Warning:
		texture.set_texture("res://assets/in-game-alerts/warning.png")
	elif type is MessageType.Danger:
		texture.set_texture("res://assets/in-game-alerts/danger.png")
	elif type is MessageType.Info:
		texture.set_texture("res://assets/in-game-alerts/info.png")
