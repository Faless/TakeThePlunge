extends Node
class_name PlayerControls

@onready var sync := $MultiplayerSynchronizer as MultiplayerSynchronizer

var player := 1 :
	set(value):
		player = value
		if sync: sync.set_multiplayer_authority(value)

var input_dir := Vector2()
var jumping := false


func _ready():
	sync.set_multiplayer_authority(player)


func _physics_process(delta):
	if multiplayer.get_unique_id() != player:
		return

	# Get the input direction and handle the movement/deceleration.
	input_dir = Input.get_vector("strafe_left", "strafe_right", "move_forward", "move_backward")
	jumping = false
	if Input.is_action_just_pressed("action_jump"):
		jump.rpc()

@rpc(call_local)
func jump():
	jumping = true
