extends KinematicBody2D

export var move_speed = 200.0
var position_player := Vector2.ZERO

# horizontal movement
var is_right
var is_left
var is_up
var is_down

# joystick signal
var is_joystick_in_use

# life indicator
var health_bar
var hp_max = 100
var actual_hp = hp_max

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationTree.active = true
	is_joystick_in_use = false
	health_bar = get_tree().get_nodes_in_group("Hp")[0]
	$CollisionPolygon2D.scale = Vector2(1, 1)
	$Sprite.flip_h = false
	$Sprite.flip_v = false


func _physics_process(_delta):
	$AnimationTree.set("parameters/orientation/current", 0)
	$Sprite.flip_v = false
	position_player.y = get_input_position_player_v() * move_speed
	position_player.x = get_input_position_player() * move_speed
	
	position_player = move_and_slide(position_player, Vector2.UP)
	update_life()
	fix_collision_orientation()
	reset_movement_flags()
	reset_movement_flags_v()

func _set_hp_max(new_hp):
	hp_max = new_hp


func increase_life(health):
	actual_hp += health
	update_life()


func decrease_life(damage):
	actual_hp -= damage
	update_life()


func update_life():
	actual_hp = clamp(actual_hp, 0, hp_max)
	health_bar.value = actual_hp * health_bar.max_value / hp_max;


func get_input_position_player() -> float:
	var horizontal := 0.0
	if !is_joystick_in_use:
		is_right = Input.is_action_pressed("move_rigth")
		is_left = Input.is_action_pressed("move_left")
	
	if is_right or is_left:
		$Sprite.flip_v = false
		$CollisionPolygon2D.scale = Vector2(1, 1)		
		$AnimationTree.set("parameters/orientation/current", 0)
		
		if is_right:
			$CollisionPolygon2D.scale = Vector2(-1, 1)
			$Sprite.flip_h = true
			horizontal += 1.0
		else:
			$Sprite.flip_h = false
			horizontal -= 1.0
			
	return horizontal
	
	
func get_input_position_player_v() -> float:
	var vertical := 0.0
	if !is_joystick_in_use:
		is_up = Input.is_action_pressed("move_up")
		is_down = Input.is_action_pressed("move_down")
	
	if is_up or is_down:		
		$AnimationTree.set("parameters/orientation/current", 1)
		if is_up:
			$Sprite.flip_v = false
			vertical -= 1.0
		else:
			$CollisionPolygon2D.scale = Vector2(-1, 1)						
			$Sprite.flip_v = true
			vertical += 1.0
			
	return vertical
	
	
func fix_collision_orientation():
	var h_direction = 1
	var v_direction = 1
	
	if $Sprite.flip_h:
		h_direction = -1
		
	if is_down:
		h_direction = -1
		if $Sprite.flip_h:
			v_direction = -1
			
	if is_up:
		h_direction = 1
		if $Sprite.flip_h:
			v_direction = -1
			
	if is_right and (is_up or is_down):
		h_direction = -1
		v_direction = 1
		
	if is_left and (is_up or is_down):
		h_direction = 1
		v_direction = 1

	$CollisionPolygon2D.scale = Vector2(h_direction, v_direction)

func reset_movement_flags():
	is_right = false
	is_left = false
	
	
func reset_movement_flags_v():
	is_up = false
	is_down = false


func _on_CanvasLayer_move_signal(move_vector):
	is_joystick_in_use = true
	var x_pos = move_vector.x
	var y_pos = move_vector.y
	var range_area = 0.4
	var max_limit = 1
	
	if in_range(x_pos, range_area, max_limit) && in_range(y_pos, -max_limit, max_limit): # rigth
		is_right = true
	if in_range(x_pos, -max_limit, -range_area) && in_range(y_pos, -max_limit, max_limit): # left
		is_left = true
		
	if in_range(x_pos, -max_limit, max_limit) && in_range(y_pos, -max_limit, -range_area): # up
		is_up = true
	if in_range(x_pos, -max_limit, max_limit) && in_range(y_pos, range_area, max_limit): # down
		is_down = true
		
		
func in_range(number, mini, maxi) -> bool:
	return number >= mini && number <= maxi
