extends Actor
class_name Player

export var stomp_impulse: = 1000.0

# Calculing the _velocity.x: speedx(var) * direction( -1 <= number <= 1)
func _physics_process(delta: float) -> void:
	var is_jump_stopped := Input.is_action_just_released("jump") and _velocity.y < 0 
	var direction = Vector2(getDirection())
	
	_velocity = calculateMoveVelocity(_velocity, direction, speed, is_jump_stopped)
	_velocity.y = move_and_slide(_velocity, floor_normal).y

func _on_EnemyDetector_area_entered(area: Area2D): # _> Decrease the y axis
	_velocity = calculateStompVelocity(_velocity, stomp_impulse)
	
func _on_EnemyDetector_body_entered(body):
	if body is Enemy:
		print('Morri')
		death()

func getDirection() -> Vector2:
		return Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0 )

func calculateMoveVelocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		jump_interrupted: bool
		) -> Vector2:
			
	var default_jump_velocity = -500 # if is the jump interrupted
	var new_velocity: = linear_velocity
	
	new_velocity.x = speed.x * direction.x
	new_velocity.y += gravity * get_physics_process_delta_time()
	
	if jump_interrupted:
		new_velocity.y = default_jump_velocity
		return new_velocity
		
	if direction.y == -1.0:
		new_velocity.y = speed.y * direction.y
		
	return new_velocity
	
func calculateStompVelocity(
	linear_velocity: Vector2,
	stomp_impulse: float
) -> Vector2:
	var out: = linear_velocity
	out.y = -stomp_impulse
	return out
	
func death() -> void:
	queue_free()
	get_tree().change_scene("res://assets/source/Screens/MainScreen.tscn")
	
