extends CharacterBody3D
class_name TailShip

const SPEED = Ship.FWD_SPEED
const ROT_SPEED = Ship.ROT_SPEED

@export var follow : Ship = null
var player_idx
var _prev_pos: Vector3

func _ready():
	_prev_pos = global_transform.origin

func _physics_process(delta):
	if global_transform.origin.distance_to(_prev_pos) > 0.001:
		var dir = (global_transform.origin - _prev_pos).normalized()
		look_at(global_transform.origin + dir)
	_prev_pos = global_transform.origin
