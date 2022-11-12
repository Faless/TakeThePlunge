extends CharacterBody3D
class_name CoreCharacter

@onready var controls := $PlayerControls as PlayerControls
@onready var camera := $Camera3D as Camera3D

var player := 1 :
	set(value):
		player = value
		$PlayerControls.player = value


func _ready():
	controls.player = player
	if player == multiplayer.get_unique_id():
		camera.make_current()


func _physics_process(delta):
	controls.update_controls()
	apply_controls(delta, not multiplayer.is_server())


func apply_controls(delta: float, is_dummy: bool):
	pass
