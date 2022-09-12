extends Node2D

enum objectType {
	Blue,
	Yellow,
	Green
}

export (objectType) var object = objectType.Blue
var amount



func pickup(body):
	if object == objectType.Blue:
		amount = 10
		body.add_health(amount)
	elif object == objectType.Green:
		amount = 15
		body.add_health(amount)
	elif object == objectType.Yellow:
		amount = -50
		body.add_health(amount)

func set_sphere_position(x_player_pos, y_player_pos):
	position = Vector2(rand_range(x_player_pos, x_player_pos), rand_range(y_player_pos, y_player_pos))


func _on_Pickup2_body_entered(body):
	if body.is_in_group("Body"):
		pickup(body)
		queue_free()
