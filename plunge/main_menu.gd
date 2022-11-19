extends Control

var peer : MultiplayerPeer

func _enter_tree():
	Network.multiplayer_ready.connect(_notify_start)


func _exit_tree():
	Network.multiplayer_ready.disconnect(_notify_start)


func _notify_start():
	if multiplayer.multiplayer_peer is WebRTCMultiplayerPeer and multiplayer.is_server():
		remote_load.rpc()


@rpc(call_local)
func remote_load():
	if multiplayer.multiplayer_peer is WebRTCMultiplayerPeer:
		load_map()


func load_map(p_file:="res://game/map/map.tscn"):
	get_tree().change_scene_to_file(p_file)


func _on_echo_pressed():
	multiplayer.multiplayer_peer = EchoServer.new()
	load_map()


func _on_web_rtc_menu_start(lobby, url):
	Network.start_webrtc(lobby, url) # Map will be loaded when multiplayer is ready


func _on_enet_start(host):
	peer = ENetMultiplayerPeer.new()
	if host == "":
		peer.create_server(4343)
	else:
		peer.create_client(host, 4343)
	multiplayer.multiplayer_peer = peer
	load_map()
