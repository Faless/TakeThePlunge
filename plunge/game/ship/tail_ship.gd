extends CharacterBody3D
class_name TailShip

const SPEED = Ship.FWD_SPEED
const ROT_SPEED = Ship.ROT_SPEED

@export var follow : Ship = null

func _physics_process(delta):
	if follow == null:
		return

	var fp := follow.position

	# Look at other ship
	var direction := position.direction_to(fp)

	# Try to move closer
	if position.distance_squared_to(fp) > 16:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	#look_at(fp)
	#rotation = rotation.rotated(Vector3(0,1,0), position.angle_to(fp))
#	rotation = look_quat.get_euler() #basis.get_rotation_quaternion().slerp(look_quat, delta * ROT_SPEED).get_euler()
