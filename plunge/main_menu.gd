extends Control

var peer : MultiplayerPeer

func load_map(p_file:="res://game/map/map.tscn"):
	get_tree().change_scene_to_file(p_file)


func _on_echo_pressed():
	multiplayer.multiplayer_peer = EchoServer.new()
	load_map()


func _on_server_pressed():
	peer = ENetMultiplayerPeer.new()
	peer.create_server(4343)
	multiplayer.multiplayer_peer = peer
	load_map()


func _on_client_pressed():
	peer = ENetMultiplayerPeer.new()
	peer.create_client("127.0.0.1", 4343)
	multiplayer.multiplayer_peer = peer
	load_map()
