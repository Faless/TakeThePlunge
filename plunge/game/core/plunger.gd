extends Node3D
class_name Plunger

signal plunged(lump_transform: Transform3D, lump_linear_velocity: Vector3)

@export var plunge_velocity := Vector3(0, 10, 0)
@export_range(0.0, 5.0, 0.1) var auto_plunge := 0.0

func _ready():
	if not is_zero_approx(auto_plunge):
		$Timer.wait_time = auto_plunge
		$Timer.start()

func plunge():
	if not multiplayer.is_server():
		return
	var lump_transform := global_transform
	plunged.emit(lump_transform, lump_transform.basis.get_rotation_quaternion() * plunge_velocity)
