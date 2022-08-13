extends KinematicBody2D

export var move_speed = 200.0
var position_player := Vector2.ZERO

# jump with gravity values
export var jump_height : float
export var jump_time_to_peak : float
export var jump_time_to_descent : float

onready var jump_position_player : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

# horizontal movement
var is_right
var is_left
var duck
var can_jump

# joystick signal
var is_joystick_in_use


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationTree.active = true
	is_joystick_in_use = false
	can_jump = false

func _physics_process(delta):
	position_player.y += get_gravity() * delta
	position_player.x = get_input_position_player() * move_speed
	
	if (Input.is_action_just_pressed("move_up") or can_jump) and is_on_floor():
		jump()
	
	position_player = move_and_slide(position_player, Vector2.UP)

	if is_on_floor():
		$AnimationTree.set("parameters/state/current", 0)
	else:
		$AnimationTree.set("parameters/state/current", 1)


func get_gravity() -> float:
	return jump_gravity if position_player.y < 0.0 else fall_gravity

func jump():
	position_player.y = jump_position_player
	can_jump = false

func get_input_position_player() -> float:
	var horizontal := 0.0
	if !is_joystick_in_use:
		is_right = Input.is_action_pressed("move_rigth")
		is_left = Input.is_action_pressed("move_left")
		duck = Input.is_action_pressed("move_down")
	
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
		is_joystick_in_use = false
		if duck:
			$AnimationTree.set("parameters/iddle/current", 1)
		else:
			$AnimationTree.set("parameters/iddle/current", 0)
	
	# fall fast
	if not is_on_floor() && duck:
		fall_gravity = fall_gravity * 2 
			
	reset_movement_flags()
	return horizontal
	
func reset_movement_flags():
	is_right = false
	is_left = false
	duck = false


func _on_CanvasLayer_move_signal(move_vector):
	
	is_joystick_in_use = true
	var x_pos = move_vector.x
	var y_pos = move_vector.y
	var range_area = 0.4
	var max_limit = 1

	# Joystick position
	var rigth_cuadrant = in_range(x_pos, range_area, max_limit) && in_range(y_pos, -max_limit, max_limit)
	var left_cuadrant = in_range(x_pos, -max_limit, -range_area) && in_range(y_pos, -max_limit, max_limit)
	var up_cuadrant = in_range(x_pos, -max_limit, max_limit) && in_range(y_pos, -max_limit, -range_area) && is_on_floor()
	var down_cuadrant = in_range(x_pos, -range_area, range_area) && in_range(y_pos, range_area, max_limit) && is_on_floor()
	
	if rigth_cuadrant: # rigth
		is_right = true

	if left_cuadrant: # left
		is_left = true
		
	if up_cuadrant: # up
		can_jump = true
	if down_cuadrant: # down
		duck = true
		
func in_range(number, mini, maxi) -> bool:
	return number >= mini && number <= maxi
