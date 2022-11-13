extends CoreCharacter

const FWD_SPEED := 5.0
const BACK_SPEED := 3.0
const ROT_SPEED := 20.0
const FIRE_TIME := 1.0

enum PLUNG_DIRECTION {ALL, LEFT, RIGHT}

signal plunged(lump_transform: Transform3D, lump_linear_velocity: Vector3)

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	super()
	for p in $Plungers.get_children():
		var sig = plunged
		p.plunged.connect(func(t, v): sig.emit(t, v))


func apply_controls(delta: float, is_dummy: bool):
	if is_dummy:
		# Implement interpolation?
		return

	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	var fwd = controls.axises[0]
	var speed = FWD_SPEED if fwd >= 0.0 else BACK_SPEED
	var side = controls.axises[1]
	if not is_zero_approx(side):
		rotate(Vector3.UP, deg_to_rad(ROT_SPEED) * side * delta)

	var direction := (global_transform.basis.get_rotation_quaternion() * Vector3(0, 0, fwd)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	move_and_slide()


func _on_player_controls_triggered(index):
	if index == PLUNG_DIRECTION.LEFT or index == PLUNG_DIRECTION.ALL:
		$Plungers/LB.plunge()
		$Plungers/LF.plunge()
	if index == PLUNG_DIRECTION.RIGHT or index == PLUNG_DIRECTION.ALL:
		$Plungers/RB.plunge()
		$Plungers/RF.plunge()
