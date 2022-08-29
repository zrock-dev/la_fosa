extends Area2D

onready var original_pos = position
var up = true
var can_move = true

var frames_count = 0
var timeout_count = 0


func _ready():
	position = Vector2(rand_range(10, 990), rand_range(10, 590))

func _process(_delta):
	if can_move: 
		move_sphere()

func move_sphere():
	if frames_count < 120:
		if up:
			position.y += .5
		else:
			position.y -= .5
		frames_count += 1
	else: 
		up = !up
		frames_count = 0


func _on_StaticBody2D_body_entered(body):
	if body.name == "Fish":
		can_move = false
		$Timer.start()
		

func _on_StaticBody2D_body_exited(body):
	if body.name == "Fish":
		can_move = true
		timeout_count = 0
		$Sprite.frame = 0
		$Timer.stop()

func _on_Timer_timeout():
	if timeout_count <= 2:
		timeout_count += 1
		$Sprite.frame += 1
	# Degradates the sphere every second


