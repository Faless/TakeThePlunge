extends Node
class_name PlayerControls

var player := 1 :
	set(value):
		player = value
		set_multiplayer_authority(player, true)

var input_dir := Vector2()
var jumping := false


func _ready():
	set_multiplayer_authority(player, true)


func _physics_process(delta):
	jumping = false
	if multiplayer.get_unique_id() != player:
		return

	# Get the input direction and handle the movement/deceleration.
	input_dir = Input.get_vector("strafe_left", "strafe_right", "move_forward", "move_backward")
	if Input.is_action_just_pressed("action_jump"):
		jump.rpc()

@rpc(call_local)
func jump():
	jumping = true
