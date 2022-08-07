extends KinematicBody2D
signal hit


# Declare member variables here. Examples:
export var speed = 350
export var jump_height : float
export var jump_time_to_peak : float
export var jump_time_to_descent : float

onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

var screen_size


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	
	velocity = move_player(velocity)
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	
func get_gravity(velocity) -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity


func move_player(velocity):
	
	if Input.is_action_pressed("move_rigth"):
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_h = false
		velocity.x += .2
		
	elif Input.is_action_pressed("move_left"):
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_h = true
		velocity.x -= .2
		
	elif Input.is_action_pressed("move_down"):
		$AnimatedSprite.animation = "sit"
	
	elif Input.is_action_pressed("move_up"):
		$AnimatedSprite.animation = "jump"
		velocity.y = jump_velocity
		
	else:
		$AnimatedSprite.animation = "default"
		velocity.y = 0
		
	return velocity


func start():
	$AnimatedSprite.animation = "default"
