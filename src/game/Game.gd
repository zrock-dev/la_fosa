extends Node2D

func _on_Fish_dead(path):
	load_game_over(path)

func _on_Player_dead(path):
	load_game_over(path)

func load_game_over(path):
	var game_over = preload("res://src/game_over/game_over.tscn").instance()
	game_over.set_before_scene(path)
	add_child(game_over)
