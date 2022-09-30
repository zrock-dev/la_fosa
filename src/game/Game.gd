extends Node2D

func _ready():
	get_tree().paused = false

func _on_Fish_player_deaded():
	load_game_over( "res://src/game/GameFish.tscn")

func _on_Player_player_deaded():
	load_game_over("res://src/game/Game.tscn")

func load_game_over(path_to_scene):
	var game_over = preload("res://src/game_over/game_over.tscn").instance()
	game_over.set_before_scene(path_to_scene)
	add_child(game_over)
