extends KinematicBody2D

export var move_speed = 200.0
export var FRAMES_CONSTRICTION = 20
var position_player := Vector2.ZERO

# life indicator
var health_bar
var hp_max = 100
var actual_hp = hp_max

# jump with gravity values
export var jump_height : float
export var jump_time_to_peak : float
export var jump_time_to_descent : float

onready var jump_position_player : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

var frames_wait = FRAMES_CONSTRICTION

# horizontal movement
var is_right : bool
var is_left : bool
var down : bool
var can_jump : bool

# joystick signal
var is_joystick_in_use


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationTree.active = true
	is_joystick_in_use = false
	can_jump = false
	health_bar = get_tree().get_nodes_in_group("Hp")[0]

func _physics_process(delta):
	position_player.y += get_gravity() * delta
	position_player.x = get_input_position_player() * move_speed
	
	if can_jump and is_on_floor():
		jump()
	
	position_player = move_and_slide(position_player, Vector2.UP)

	if is_on_floor():
		$AnimationTree.set("parameters/state/current", 0)
	else:
		$AnimationTree.set("parameters/state/current", 1)

func _set_hp_max(new_hp):
	hp_max = new_hp

func set_hp(new_hp):
	actual_hp = new_hp;
	update_life()

func update_life():
	actual_hp = clamp(actual_hp, 0, health_bar.max_value)
	health_bar.value = actual_hp * health_bar.max_value / hp_max;

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
		down = Input.is_action_pressed("move_down")
		can_jump = Input.is_action_just_pressed("move_up")
	
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

		if down && is_on_floor():
			$AnimationTree.set("parameters/iddle/current", 1)
		else:
			$AnimationTree.set("parameters/iddle/current", 0)
	
	check_fall_fast()
	reset_movement_flags()
	return horizontal
	
func reset_movement_flags():
	is_right = false
	is_left = false
	down = false

func _on_CanvasLayer_move_signal(move_vector):

	# var y_control = Vector2.AXIS_Y
	
	is_joystick_in_use = true
	var x_pos = move_vector.x
	var y_pos = move_vector.y

	var x_dist = 1 - abs_of(x_pos)
	var y_dist = 1 - abs_of(y_pos)
	var max_dist_from_border = .8
	
	# Joystick position
	is_right = (x_pos > 0) && (x_dist < max_dist_from_border)
	is_left = (x_pos < 0) && (x_dist < max_dist_from_border)

	if frames_wait == FRAMES_CONSTRICTION:
		can_jump = (y_pos < 0) && (y_dist < max_dist_from_border) && is_on_floor()
		frames_wait = 0
	else:
		frames_wait += .5

	down = (y_pos > 0) && (y_dist < max_dist_from_border)
	if down:
		frames_wait = FRAMES_CONSTRICTION

func check_fall_fast():
	if !is_on_floor() && down:
		position_player.y = position_player.y + 100 

func abs_of(value):
	return value if value > 0 else -value
