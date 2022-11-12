extends StaticBody3D

signal plunged(lump_transform: Transform3D, lump_linear_velocity: Vector3)

@export var rotation_speed := 1.0
@export var plunge_fuzzy := 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	for plunger in $Plungers.get_children():
		plunger.plunged.connect(_plunged)

func _plunged(lump_transform: Transform3D, lump_linear_velocity: Vector3):
	var fuzzy = Vector3.ONE * (randf() - .5) * plunge_fuzzy
	plunged.emit(lump_transform, lump_linear_velocity + fuzzy)

func _physics_process(delta):
	rotate(Vector3.UP, rotation_speed)
