extends Node3D

const Lump = preload("res://game/core/lump.tscn")

func _ready():
	if multiplayer.is_server():
		spawn_player(1)
		multiplayer.peer_connected.connect(spawn_player)
		multiplayer.peer_disconnected.connect(despawn_player)


func spawn_player(id: int):
	var ship = $PlayerSpawner.spawn(id)
	ship.plunged.connect(spawn_lump)


func despawn_player(id: int):
	for p in $Players.get_children():
		if p.player == id:
			p.queue_free()


func spawn_lump(lump_transform: Transform3D, lump_linear_velocity: Vector3):
	var lump = Lump.instantiate()
	lump.global_transform = lump_transform
	lump.linear_velocity = lump_linear_velocity
	$Objects.add_child(lump, true)
