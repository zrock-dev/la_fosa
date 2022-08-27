extends StaticBody2D

onready var original_pos = position
var up = true;

func _ready():
	$Sprite.frame = randi()%4
	position = Vector2(rand_range(10, 990), rand_range(10, 590))

var frames_count = 0;
func _process(_delta):
	if frames_count < 120:
		if up:
			position.y += .5
		else:
			position.y -= .5
		frames_count += 1
	else: 
		up = !up
		frames_count = 0
