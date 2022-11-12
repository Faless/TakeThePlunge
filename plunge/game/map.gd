extends Node3D

func _ready():
	if multiplayer.is_server():
		spawn_player(1)
		multiplayer.peer_connected.connect(spawn_player)
		multiplayer.peer_disconnected.connect(despawn_player)


func spawn_player(id: int):
	$MultiplayerSpawner.spawn(id)


func despawn_player(id: int):
	for p in $Players.get_children():
		if p.player == id:
			p.queue_free()
