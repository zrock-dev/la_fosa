extends Node2D

# bubbles generation
var bubbles = preload("res://src/fish/chemicals/bubble.tscn")
var bubbles_count = 1

func _on_Timer_timeout():
	randomize()
	add_child(bubbles.instance())
	if bubbles_count < 5:
		bubbles_count += 1
	else:
		$Timer.stop()
		$Timer.autostart = false
