extends Control

var peer : MultiplayerPeer

func _on_echo_pressed():
	multiplayer.multiplayer_peer = EchoServer.new()
	get_tree().change_scene_to_file("res://game/map.tscn")


func _on_server_pressed():
	peer = ENetMultiplayerPeer.new()
	peer.create_server(4343)
	multiplayer.multiplayer_peer = peer
	get_tree().change_scene_to_file("res://game/map.tscn")


func _on_client_pressed():
	peer = ENetMultiplayerPeer.new()
	peer.create_client("127.0.0.1", 4343)
	multiplayer.multiplayer_peer = peer
	get_tree().change_scene_to_file("res://game/map.tscn")
