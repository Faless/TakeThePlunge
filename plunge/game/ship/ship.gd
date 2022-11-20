extends CoreCharacter
class_name Ship

const FWD_SPEED := 5.0
const BACK_SPEED := 3.0
const ROT_SPEED := 30.0
const FIRE_TIME := 1.0
const ROTATION_COOLDOWN = 0.3
const TAIL_SHIP_DISTANCE = 2.0

enum PLUNG_DIRECTION {ALL, LEFT, RIGHT}


signal plunged(lump_transform: Transform3D, lump_linear_velocity: Vector3)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

enum ROTATE_DIRECTION { NONE, LEFT, RIGHT}
var _rotate = ROTATE_DIRECTION.NONE
var _cooldown = 0.0
var ships = []
@export
var path: Curve3D = Curve3D.new()


func _ready():
	super()
	for p in $Plungers.get_children():
		var sig = plunged
		p.plunged.connect(func(t, v): sig.emit(t, v))
	path = Curve3D.new()
	path.add_point(global_transform.origin - global_transform.basis.z * 15.0)


func apply_controls(delta: float, is_dummy: bool):
	if is_dummy:
		# Implement interpolation?
		return

	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

#	var fwd = controls.axises[0]
	var fwd = 1.0
	var speed = FWD_SPEED if fwd >= 0.0 else BACK_SPEED
#	var side = controls.axises[1]
#	if not is_zero_approx(side):
#		rotate(Vector3.UP, deg_to_rad(ROT_SPEED) * side)
	_cooldown -= delta
	if _cooldown < 0.0:
		match _rotate:
			ROTATE_DIRECTION.LEFT:
				rotate( Vector3.UP, deg_to_rad(ROT_SPEED))
				_rotate = ROTATE_DIRECTION.NONE
				_cooldown = ROTATION_COOLDOWN
				path.add_point(global_transform.origin)
			ROTATE_DIRECTION.RIGHT:
				rotate( Vector3.UP, -deg_to_rad(ROT_SPEED))
				_rotate = ROTATE_DIRECTION.NONE
				_cooldown = ROTATION_COOLDOWN
				path.add_point(global_transform.origin)
			_:
				pass

	var direction := (global_transform.basis.get_rotation_quaternion() * Vector3(0, 0, fwd)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	move_and_slide()
	update_follow_ships()

func update_follow_ships():
	var ship_to_path_distance = global_transform.origin.distance_to(path.get_point_position(path.point_count-1))
	var last_point_position = path.get_point_position(path.point_count-1)
	for i in range(ships.size()):
		var current_ship_distance = TAIL_SHIP_DISTANCE + TAIL_SHIP_DISTANCE * i
		if current_ship_distance < ship_to_path_distance:
			ships[i].global_transform.origin = lerp(global_transform.origin, last_point_position, current_ship_distance / ship_to_path_distance)
			ships[i].look_at(global_transform.origin, Vector3.UP)
		else:
			var distance_on_path = current_ship_distance - ship_to_path_distance
			ships[i].global_transform.origin = path.sample_baked(path.get_baked_length() - distance_on_path)
#		print(current_ship_distance)
#		print("My position: ",global_transform.origin, " - my baby position ", ships[i].global_transform.origin )

func _on_player_controls_triggered(index):
	if index < 3:
		var group = &"cannon"
		if index == PLUNG_DIRECTION.LEFT:
			group = &"left"
		elif index == PLUNG_DIRECTION.RIGHT:
			group = &"right"
		for p in $Plungers.get_children():
			if p.is_in_group(group):
				p.plunge()
	if index == 3:
		_rotate = ROTATE_DIRECTION.LEFT
	elif index == 4:
		_rotate = ROTATE_DIRECTION.RIGHT
