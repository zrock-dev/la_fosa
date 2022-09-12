extends Node2D

export var amount = 10

func _ready():
	pass

func _on_PickUps_body_entered(body: Node) -> void:
	if body.is_in_group("Body"):
		pickup(body)
		queue_free()
	pass # Replace with function body.

func pickup(body):
	body.add_health(amount)
