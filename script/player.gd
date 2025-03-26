extends CharacterBody2D

const MAX_SPEED = 300.0  # Maximum movement speed
const ACCELERATION = 800.0  # Speed increase per second
const FRICTION = 600.0  # Slows down when no input

var target_velocity = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	
	if Input.is_action_pressed("ui_right") and velocity.x >= 0:
		input_vector.x += 1
	elif Input.is_action_pressed("ui_left") and velocity.x <= 0:
		input_vector.x -= 1

	if Input.is_action_pressed("ui_down") and velocity.y >= 0:
		input_vector.y += 1
	elif Input.is_action_pressed("ui_up") and velocity.y <= 0:
		input_vector.y -= 1

	# Normalize diagonal movement
	input_vector = input_vector.normalized()

	# Apply acceleration or deceleration
	if input_vector != Vector2.ZERO:
		target_velocity = target_velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		target_velocity = target_velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	velocity = target_velocity
	move_and_slide()

	# Flip sprite based on horizontal movement
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false  # Face right
	elif velocity.x < 0:
		$AnimatedSprite2D.flip_h = true  # Face left
