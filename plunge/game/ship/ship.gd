extends CoreCharacter

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func apply_controls(delta: float, is_dummy: bool):
	if is_dummy:
		# Implement interpolation?
		return

	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if controls.triggers[0] and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := (transform.basis * Vector3(controls.axies[1], 0, controls.axies[0])).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()
