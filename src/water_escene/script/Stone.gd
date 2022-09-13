#A stone that will simply fall into the water
extends KinematicBody2D

#the gravity value
var gravity = 35

#the motion vector
#we'll use it to move our stone with move_and_slide
var position_player = Vector2.ZERO

#so the stone won't accelerate forever
var max_speed = 450

var max_speed_in_water = 200

func _physics_process(delta):
	#at each frame add gravity to our motion vector
	#clamp the motion value to the speed
	#move the stone with move_and_slide
	position_player.y += gravity
	position_player.y = clamp(position_player.y, -max_speed, max_speed)
	position_player = move_and_slide(position_player)

#initializes the stone at a set position
func initialize(pos):
	global_position = pos

func in_water():
	gravity = gravity / 3
	max_speed = max_speed_in_water
