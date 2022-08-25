extends Control


func _on_Fish_pressed():
	get_tree().change_scene("res://src/game/GameFish.tscn")


func _on_Dog_pressed():
	get_tree().change_scene("res://src/game/Game.tscn")
