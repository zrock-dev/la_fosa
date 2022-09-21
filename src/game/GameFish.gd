extends Node2D
const MAXIMUM_AUTOMATIC_SPHERES_AMOUNT = 5

# bubbles generation
var Bubbles = preload("res://src/fish/chemicals/bubble.tscn")
var spheres_amount_limit


func _ready():
	generate_spheres(MAXIMUM_AUTOMATIC_SPHERES_AMOUNT)


func _on_Timer_timeout():
	randomize()
	var sphere = Bubbles.instance()
	add_child(sphere)
	sphere.add_to_group("bubbles")
	sphere.target = $Fish
	sphere.set_sphere_position($Fish.position.x, $Fish.position.y)
	check_spheres_limit()


func generate_spheres(amount=1):
	spheres_amount_limit = amount
	$SphereCreationTimer.start()
	$SphereCreationTimer.autostart = true
	
	
func check_spheres_limit():
	if spheres_amount_limit > 0:
		spheres_amount_limit -= 1
	else:
		$SphereCreationTimer.stop()
		$SphereCreationTimer.autostart = false
