extends Node3D

@onready var player_spawer := $MultiplayerSpawner as MultiplayerSpawner

# Called when the node enters the scene tree for the first time.
func _ready():
	if multiplayer.is_server():
		spawn_player(1)
		multiplayer.peer_connected.connect(spawn_player)


func spawn_player(id: int):
	player_spawer.spawn(id)
