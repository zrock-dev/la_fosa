extends RigidBody2D

onready var original_pos = position
var up = true;


# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.frame = randi()%4


# Called every frame. 'delta' is the elapsed time since the previous frame.
var frames_count = 0;
func _process(_delta):
	if frames_count < 60:
		if up:
			position.y += 1
		else:
			position.y -= 1
		frames_count += 1
	else: 
		up = !up
		frames_count = -30
		#position = original_pos
		linear_velocity. y = 0
#	pass
