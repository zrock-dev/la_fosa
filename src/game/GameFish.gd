extends Node2D

# bubbles generation
var Bubbles = preload("res://src/fish/chemicals/bubble.tscn")
var bubbles_count = 1

func _on_Timer_timeout():
	randomize()
	var bubbles_object = Bubbles.instance()
	add_child(bubbles_object)
	bubbles_object.add_to_group("bubbles")
	bubbles_object.target = $Fish 
	
	if bubbles_count < 5:
		bubbles_count += 1
	else:
		$Timer.stop()
		$Timer.autostart = false
		
