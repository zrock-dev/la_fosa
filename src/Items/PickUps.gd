extends Node2D

export var Health = 0
export var amount = 10

func _ready():
	pass

func _on_PickUps_body_entered(body):
	pickup(body)
	queue_free()
	pass # Replace with function body.

func pickup(body):
	body.add_health(amount)
