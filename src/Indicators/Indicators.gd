extends Control

var text
var color

enum MessageType {Info, Warning, Danger}

func _Message(var message, var type):
	if type is MessageType.Warning:
		print("go")
		#$Icon.texture.load_path = "res://assets/icon/alert.png"
	$Text._set_text(message)


func _on_Indicators_ready():
	#_Message("WARNING", MessageType.Warning)
	$Icon.texture.
	$Icon.texture.load_path = "res://assets/icon/alert.png"
	print("hola")
