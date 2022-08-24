extends CanvasLayer

signal move_signal
var move_vector = Vector2(0,0)
var joystick_active = false
var limit = 90

func _input(event):
	if (event is InputEventScreenTouch and event.is_pressed()) or event is InputEventScreenDrag:
		move_vector = calculate_move_vector(event.position)
		limit_the_inner_circle(event.position)
	if event is InputEventScreenTouch and not event.is_pressed():
		joystick_active = false

	$InnerCircle.visible = joystick_active

func _physics_process(_delta):
	if joystick_active:
		emit_signal("move_signal", move_vector)
		#print(move_vector)
		
		

func calculate_move_vector(event_position):
	return (event_position - get_texture_center()).normalized()

func limit_the_inner_circle(event_position):
	var texture_center = get_texture_center()
	
	if texture_center.distance_to(event_position) > limit:
		var limit_vector = move_vector * limit
		$InnerCircle.position = texture_center + limit_vector
	else:
		$InnerCircle.position = event_position
		joystick_active = true		

func get_texture_center():
	return $TouchScreenButton.position + Vector2(limit, limit)
