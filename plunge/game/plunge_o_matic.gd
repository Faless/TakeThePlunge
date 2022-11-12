extends StaticBody3D

signal plunged(lump_transform: Transform3D, lump_linear_velocity: Vector3)

# Called when the node enters the scene tree for the first time.
func _ready():
	for plunger in $Plungers.get_children():
		plunger.plunged.connect(_plunged)

func _plunged(lump_transform: Transform3D, lump_linear_velocity: Vector3):
	plunged.emit(lump_transform, lump_linear_velocity)
