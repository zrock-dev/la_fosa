extends Node2D

var PickupBlue = preload("res://src/Pickups/PickupBlue.tscn")
var PickupGreen = preload("res://src/Pickups/PickupGreen.tscn")
var PickupYellow = preload("res://src/Pickups/PickupYellow.tscn")

func _ready():
	generate_pickups(PickupBlue, 200, 100)
	generate_pickups(PickupYellow, 300, 100)
	generate_pickups(PickupGreen, 200, 300)
	generate_pickups(PickupYellow, 400, 200)
	
func generate_pickups(type_item, pos_x, pos_y):
	var pickup
	if type_item == PickupBlue:
		pickup = PickupBlue.instance()
	if type_item == PickupGreen:
		pickup = PickupGreen.instance()
	if type_item == PickupYellow:
		pickup = PickupYellow.instance()
	add_child(pickup)
	pickup.set_sphere_position($Pickup.position.x + pos_x, $Pickup.position.y + pos_y)
	
