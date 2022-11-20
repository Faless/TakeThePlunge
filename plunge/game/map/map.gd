extends Node3D

const CannonBall = preload("res://game/ship/cannonball.tscn")
const TailShipScene = preload("res://game/ship/tail_ship.tscn")

func _ready():
	randomize()
	if multiplayer.is_server():
		spawn_player(1)
		for id in multiplayer.get_peers():
			# Spawn already connected players
			spawn_player(id)
		multiplayer.peer_connected.connect(spawn_player)
		multiplayer.peer_disconnected.connect(despawn_player)


func spawn_player(id: int):
	var ship = $PlayerSpawner.spawn(id)
	ship.plunged.connect(spawn_lump)
	for i in range(4):
		var tail_ship = TailShipScene.instantiate()
		tail_ship.player_idx = id
		$Objects.add_child(tail_ship, true)
		ship.ships.append(tail_ship)
#		print("adding boat")
	ship.update_follow_ships()


func despawn_player(id: int):
	for p in $Players.get_children():
		if p.player == id:
			p.queue_free()


func spawn_lump(lump_transform: Transform3D, lump_linear_velocity: Vector3):
	var lump = CannonBall.instantiate()
	lump.global_transform = lump_transform
	lump.linear_velocity = lump_linear_velocity
	$Objects.add_child(lump, true)
