extends Control

onready var label := $HBoxContainer/Label
onready var texture := $HBoxContainer/TextureRect
onready var label_color = $HBoxContainer/Label.get_stylebox("normal", "")

var info_image = preload("res://assets/in-game-alerts/info.png")
var warning_image = preload("res://assets/in-game-alerts/warning.png")
var danger_image = preload("res://assets/in-game-alerts/danger.png")

var timer = 0

enum MessageType {Info, Warning, Danger}

func _Message(var message, var type):
	label.text = message
	
	if type == MessageType.Warning:
		texture.set_texture(warning_image)
		label_color.border_color = Color.yellow
	elif type == MessageType.Danger:
		texture.set_texture(danger_image)
		label_color.border_color = Color.red
	elif type == MessageType.Info:
		texture.set_texture(info_image)
		label_color.border_color = Color.blue
		
	label_color.bg_color = label_color.border_color


func _on_Timer_timeout():
	print ("Timeout timer: ", timer)
	if timer == 0:
		_Message("This is a info message", MessageType.Info)
		timer += 1
	elif timer == 1:
		_Message("This is a danger message", MessageType.Danger)
		timer += 1
	elif timer == 2:
		_Message("This is a warning message", MessageType.Warning)
		timer = 0
