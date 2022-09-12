extends Node2D

var PickupBlue = preload("res://src/Pickups/PickupBlue.tscn")
var PickupGreen = preload("res://src/Pickups/PickupGreen.tscn")
var PickupYellow = preload("res://src/Pickups/PickupYellow.tscn")

func _ready():
	generate_pickups(PickupBlue, 200, 10)
	generate_pickups(PickupYellow, 300, 10)
	generate_pickups(PickupGreen, 350, -50)
	generate_pickups(PickupYellow, 550, -100)
	generate_pickups(PickupGreen, 690, -160)
	
func generate_pickups(type_item, pos_x, pos_y):
	var pickup
	if type_item == PickupBlue:
		pickup = PickupBlue.instance()
	if type_item == PickupGreen:
		pickup = PickupGreen.instance()
	if type_item == PickupYellow:
		pickup = PickupYellow.instance()
	add_child(pickup)
	pickup.set_sphere_position($Player.position.x + pos_x, $Player.position.y + pos_y)
