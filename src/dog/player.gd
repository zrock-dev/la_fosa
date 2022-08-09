extends KinematicBody2D

export var move_speed = 200.0
var position_player := Vector2.ZERO

export var jump_height : float
export var jump_time_to_peak : float
export var jump_time_to_descent : float

onready var jump_position_player : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationTree.active = true

func _physics_process(delta):
	position_player.y += get_gravity() * delta
	position_player.x = get_input_position_player() * move_speed
	
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		jump()
	
	position_player = move_and_slide(position_player, Vector2.UP)

func get_gravity() -> float:
	if position_player.y < 0.0:
		$AnimationTree.set("parameters/state/current", 1)
		return jump_gravity
	else:
		$AnimationTree.set("parameters/state/current", 0)
		return fall_gravity

func jump():
	position_player.y = jump_position_player

func get_input_position_player() -> float:
	var horizontal := 0.0
	var is_right = Input.is_action_pressed("move_rigth")
	var is_left = Input.is_action_pressed("move_left")
	var is_down = Input.is_action_pressed("move_down")
	
	if is_right or is_left:
		$AnimationTree.set("parameters/movement/current", 1)
		if is_right:
			$Sprite.flip_h = false
			horizontal += 1.0
		else:
			$Sprite.flip_h = true
			horizontal -= 1.0
	else:
		$AnimationTree.set("parameters/movement/current", 0)
		if is_down:
			$AnimationTree.set("parameters/iddle/current", 1)
		else:
			$AnimationTree.set("parameters/iddle/current", 0)
	return horizontal
