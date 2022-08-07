extends Node2D


# Declare member variables here. Examples:
enum MessageType {Info, Warning, Danger}
# Called when the node enters the scene tree for the first time.
var type = "Info"
func _Message(var message, var type):
	if type is MessageType.Info:
		print(message + "verde")
	if type is MessageType.Warning:
		print(message + "amarillo")
	if type is MessageType.Danger:
		print(message + "rojo")
