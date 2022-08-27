extends Node2D

# bubbles generation
var bubbles = preload("res://src/fish/chemicals/bubble.tscn")

func _on_Timer_timeout():
	randomize()
	add_child(bubbles.instance())
