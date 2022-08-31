extends Area2D

# Textures
var clorox = preload("res://assets/fish/chemicals/clorox.png")
var oil = preload("res://assets/fish/chemicals/oil.png")
var garbage_liquid = preload("res://assets/fish/chemicals/garbage_liquid.png")
var garbage_bubbles = preload("res://assets/fish/chemicals/garbage_bubbles.png")

onready var original_pos = position
onready var target

const DEFAULT_HIT_WAIT_TIME = 120
const NORMAL_HIT = 10
const EXPLOSION_HIT = 100

var vertical_movement = true
var can_move = true

var hit_player_wait_time = DEFAULT_HIT_WAIT_TIME

var frames_count = 0
var timeout_count = 0

func _ready():
	var textures = [clorox, oil, garbage_liquid, garbage_bubbles]
	$Sprite.texture = textures[randi()%3]
	position = Vector2(rand_range(10, 990), rand_range(10, 590))

func _process(_delta):
	if can_move: 
		move_sphere()
	else:
		damage_player()
	

func move_sphere():
	if frames_count < 120:
		if vertical_movement:
			position.y += .5
		else:
			position.y -= .5
		frames_count += 1
	else: 
		vertical_movement = !vertical_movement
		frames_count = 0
		

func damage_player():
	if hit_player_wait_time == 0:
		hit_player()
		hit_player_wait_time = DEFAULT_HIT_WAIT_TIME
	else:
		hit_player_wait_time -= 1


func _on_StaticBody2D_body_entered(body):
	if body.name == "Fish":
		can_move = false
		$Timer.start()
		

func _on_StaticBody2D_body_exited(body):
	if body.name == "Fish":
		reset_bubble()


func _on_Timer_timeout():
	if timeout_count <= 2:
		timeout_count += 1
		$Sprite.frame += 1
		
	if $Sprite.frame == 2:
		$Timer.wait_time += 2
	
	if $Sprite.frame == 3:
		hit_player(EXPLOSION_HIT)


func reset_bubble():
	can_move = true
	timeout_count = 0
	$Sprite.frame = 0
	$Timer.stop()
	
	
func hit_player(damage = NORMAL_HIT):
	target.decrease_life(damage)
