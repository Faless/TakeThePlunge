extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var ctrls := $PlayerControls as PlayerControls

var player := 1 :
	set(value):
		player = value
		if ctrls:
			ctrls.player = value

func _ready():
	if str(name).is_valid_int():
		self.player = str(name).to_int()

func apply_controls():
	# Handle Jump.
	if ctrls.jumping and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = (transform.basis * Vector3(ctrls.input_dir.x, 0, ctrls.input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	if multiplayer.is_server():
		apply_controls()
		move_and_slide()
